{...}: {
  flake.modules.homeManager.awww = {
    pkgs,
    lib,
    osConfig,
    ...
  }: let
    wallpaperRegistry = import ../../../../assets/wallpapers/registry.nix {config = osConfig;};

    oppositeMode =
      if osConfig.my.host.wallpaper.mode == "dark"
      then "light"
      else "dark";

    wallpaperModeConfig = packConfig: let
      requestedModeConfig = packConfig.${osConfig.my.host.wallpaper.mode} or null;
      fallbackModeConfig = packConfig.${oppositeMode} or null;
    in
      if requestedModeConfig != null
      then requestedModeConfig
      else if fallbackModeConfig != null
      then fallbackModeConfig
      else throw "Wallpaper pack '${osConfig.my.host.wallpaper.pack}' has no '${osConfig.my.host.wallpaper.mode}' or '${oppositeMode}' mode";

    monitors = osConfig.my.host.monitors;
    monitorCount = builtins.length monitors;

    targetLayout =
      if osConfig.my.host.wallpaper.layoutPreference == "auto"
      then
        if monitorCount > 1
        then "dual-span"
        else "single"
      else osConfig.my.host.wallpaper.layoutPreference;

    targetWidth =
      if targetLayout == "dual-span"
      then builtins.foldl' (acc: m: acc + m.width) 0 monitors
      else
        builtins.foldl' (acc: m:
          if m.primary
          then m.width
          else acc)
        0
        monitors;

    targetHeight =
      if targetLayout == "dual-span"
      then
        builtins.foldl' (acc: m:
          if m.height > acc
          then m.height
          else acc)
        0
        monitors
      else
        builtins.foldl' (acc: m:
          if m.primary
          then m.height
          else acc)
        0
        monitors;

    packConfig = wallpaperRegistry.packs.${osConfig.my.host.wallpaper.pack};
    modeConfig = wallpaperModeConfig packConfig;

    allCandidates =
      if modeConfig ? wallpapers
      then modeConfig.wallpapers
      else let
        packModeLayouts = modeConfig.layouts or {};
      in
        (packModeLayouts.${targetLayout} or []) ++ (packModeLayouts.single or []);

    candidateName = wallpaper: baseNameOf wallpaper.path;

    namedWallpaper =
      if osConfig.my.host.wallpaper.name == null
      then null
      else let
        matches = builtins.filter (w: candidateName w == osConfig.my.host.wallpaper.name) allCandidates;
      in
        if matches == []
        then throw "Wallpaper '${osConfig.my.host.wallpaper.name}' not found in pack='${osConfig.my.host.wallpaper.pack}' mode='${osConfig.my.host.wallpaper.mode}'"
        else builtins.head matches;

    byAreaThenPriority = a: b: let
      aArea = a.width * a.height;
      bArea = b.width * b.height;
    in
      if aArea == bArea
      then (a.priority or 0) > (b.priority or 0)
      else aArea < bArea;

    pickBest = candidates: reqWidth: reqHeight: let
      valid = builtins.filter (w: w.width >= reqWidth && w.height >= reqHeight) candidates;
    in
      if valid == []
      then null
      else builtins.head (builtins.sort byAreaThenPriority valid);

    selectedLayoutWallpaper = pickBest allCandidates targetWidth targetHeight;

    primaryMonitor =
      builtins.foldl'
      (
        acc: m:
          if acc != null
          then acc
          else if m.primary
          then m
          else null
      )
      null
      monitors;

    singleTargetWidth =
      if primaryMonitor != null
      then primaryMonitor.width
      else targetWidth;
    singleTargetHeight =
      if primaryMonitor != null
      then primaryMonitor.height
      else targetHeight;
    selectedSingleWallpaper = pickBest allCandidates singleTargetWidth singleTargetHeight;

    selectedWallpaper =
      if namedWallpaper != null
      then namedWallpaper.path
      else if selectedLayoutWallpaper != null
      then selectedLayoutWallpaper.path
      else if osConfig.my.host.wallpaper.fallbackPolicy == "repeat-single" && selectedSingleWallpaper != null
      then selectedSingleWallpaper.path
      else throw "No wallpaper found for pack='${osConfig.my.host.wallpaper.pack}' mode='${osConfig.my.host.wallpaper.mode}' layout='${targetLayout}'";

    awww = lib.getExe pkgs.awww;
    magick = lib.getExe pkgs.imagemagick;
    resizeMode = "fit";

    sortedMonitors = monitors;

    spanCommands = let
      mkCommand = acc: m: let
        index = acc.index;
        offsetX = acc.offsetX;
        file = "/tmp/awww-span-${toString index}.png";
        cmd = ''
          ${magick} ${lib.escapeShellArg (toString selectedWallpaper)} \
            -resize '${toString targetWidth}x${toString targetHeight}^' \
            -gravity center \
            -extent '${toString targetWidth}x${toString targetHeight}' \
            -crop '${toString m.width}x${toString m.height}+${toString offsetX}+0' +repage \
            ${lib.escapeShellArg file}

          ${awww} img --outputs ${lib.escapeShellArg m.name} --transition-type none ${lib.escapeShellArg file}
        '';
      in {
        index = index + 1;
        offsetX = offsetX + m.width;
        commands = acc.commands ++ [cmd];
      };

      result =
        builtins.foldl' mkCommand {
          index = 0;
          offsetX = 0;
          commands = [];
        }
        sortedMonitors;
    in
      lib.concatStringsSep "\n" result.commands;

    applyMonitorArgs = m: let
      monitorWallpaper = m.wallpaper or null;
      wallpaperPath =
        if monitorWallpaper != null
        then monitorWallpaper
        else selectedWallpaper;
    in ''
      ${awww} img --outputs ${lib.escapeShellArg m.name} --resize ${resizeMode} --transition-type none ${lib.escapeShellArg (toString wallpaperPath)}
    '';

    applyWallpaperScript =
      if monitors == []
      then ''
        ${awww} img --resize ${resizeMode} --transition-type none ${lib.escapeShellArg (toString selectedWallpaper)}
      ''
      else if targetLayout == "dual-span" && monitorCount > 1
      then spanCommands
      else lib.concatMapStringsSep "\n" applyMonitorArgs monitors;
  in {
    home.packages = [pkgs.imagemagick];

    services.awww.enable = true;

    systemd.user.services.awww-apply = {
      Unit = {
        Description = "Apply awww wallpapers";
        After = [
          "graphical-session.target"
          "awww.service"
        ];
        Wants = ["awww.service"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "awww-apply" ''
          set -eu

          for _ in $(seq 1 20); do
            if ${awww} query >/dev/null 2>&1; then
              break
            fi
            sleep 0.2
          done

          ${applyWallpaperScript}
        '';
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
