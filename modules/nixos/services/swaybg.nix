{
  flake.nixosModules.swaybg =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      wallpaperRegistry = import ../../../assets/wallpapers/registry.nix { inherit config; };

      oppositeMode = if config.my.host.wallpaper.mode == "dark" then "light" else "dark";

      monitors = config.my.host.monitors;
      monitorCount = builtins.length monitors;

      targetLayout =
        if config.my.host.wallpaper.layoutPreference == "auto" then
          if monitorCount > 1 then "dual-span" else "single"
        else
          config.my.host.wallpaper.layoutPreference;

      targetWidth =
        if targetLayout == "dual-span" then
          builtins.foldl' (acc: m: acc + m.width) 0 monitors
        else
          builtins.foldl' (acc: m: if m.primary then m.width else acc) 0 monitors;

      targetHeight =
        if targetLayout == "dual-span" then
          builtins.foldl' (acc: m: if m.height > acc then m.height else acc) 0 monitors
        else
          builtins.foldl' (acc: m: if m.primary then m.height else acc) 0 monitors;

      packConfig = wallpaperRegistry.packs.${config.my.host.wallpaper.pack};
      requestedModeConfig = packConfig.${config.my.host.wallpaper.mode} or null;
      fallbackModeConfig = packConfig.${oppositeMode} or null;

      modeConfig =
        if requestedModeConfig != null then
          requestedModeConfig
        else if fallbackModeConfig != null then
          fallbackModeConfig
        else
          throw "Wallpaper pack '${config.my.host.wallpaper.pack}' has no '${config.my.host.wallpaper.mode}' or '${oppositeMode}' mode";

      packModeLayouts = modeConfig.layouts or { };

      layoutCandidates = packModeLayouts.${targetLayout} or [ ];
      singleCandidates = packModeLayouts.single or [ ];

      byAreaThenPriority =
        a: b:
        let
          aArea = (a.width * a.height);
          bArea = (b.width * b.height);
        in
        if aArea == bArea then (a.priority or 0) > (b.priority or 0) else aArea < bArea;

      pickBest =
        candidates: reqWidth: reqHeight:
        let
          valid = builtins.filter (w: w.width >= reqWidth && w.height >= reqHeight) candidates;
        in
        if valid == [ ] then null else builtins.head (builtins.sort byAreaThenPriority valid);

      selectedLayoutWallpaper = pickBest layoutCandidates targetWidth targetHeight;

      primaryMonitor = builtins.foldl' (
        acc: m:
        if acc != null then
          acc
        else if m.primary then
          m
        else
          null
      ) null monitors;

      singleTargetWidth = if primaryMonitor != null then primaryMonitor.width else targetWidth;
      singleTargetHeight = if primaryMonitor != null then primaryMonitor.height else targetHeight;
      selectedSingleWallpaper = pickBest singleCandidates singleTargetWidth singleTargetHeight;

      selectedWallpaper =
        if config.my.host.wallpaper.path != null then
          config.my.host.wallpaper.path
        else if selectedLayoutWallpaper != null then
          selectedLayoutWallpaper.path
        else if
          config.my.host.wallpaper.fallbackPolicy == "repeat-single" && selectedSingleWallpaper != null
        then
          selectedSingleWallpaper.path
        else
          throw "No wallpaper found for pack='${config.my.host.wallpaper.pack}' mode='${config.my.host.wallpaper.mode}' layout='${targetLayout}'";

      monitorFlags = lib.concatMapStringsSep " " (
        m:
        let
          monitorWallpaper = m.wallpaper or null;
          wallpaperPath = if monitorWallpaper != null then monitorWallpaper else selectedWallpaper;
        in
        "-o ${m.name} -i ${toString wallpaperPath}"
      ) monitors;

      swaybgArgs = if monitors == [ ] then "-i ${toString selectedWallpaper}" else monitorFlags;
    in
    {
      environment.systemPackages = [ pkgs.swaybg ];

      systemd.user.services.swaybg = {
        description = "Swaybg Wallpaper Daemon";
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig = {
          ExecStart = "${pkgs.swaybg}/bin/swaybg ${swaybgArgs} -m fill";
          Restart = "on-failure";
        };

        enable = true;
      };
    };
}
