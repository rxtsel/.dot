{lib, ...}: {
  flake.modules.homeManager.wallust = {
    pkgs,
    osConfig,
    ...
  }: let
    mode = osConfig.my.host.wallpaper.mode;
    wallpaperRegistry = import ../../../../assets/wallpapers/registry.nix {config = osConfig;};

    oppositeMode =
      if mode == "dark"
      then "light"
      else "dark";

    wallpaperModeConfig = packConfig: let
      requestedModeConfig = packConfig.${mode} or null;
      fallbackModeConfig = packConfig.${oppositeMode} or null;
    in
      if requestedModeConfig != null
      then requestedModeConfig
      else if fallbackModeConfig != null
      then fallbackModeConfig
      else throw "Wallpaper pack '${osConfig.my.host.wallpaper.pack}' has no '${mode}' or '${oppositeMode}' mode";

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
        then throw "Wallpaper '${osConfig.my.host.wallpaper.name}' not found in pack='${osConfig.my.host.wallpaper.pack}' mode='${mode}'"
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
      builtins.foldl' (
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
      else throw "No wallpaper found for pack='${osConfig.my.host.wallpaper.pack}' mode='${mode}' layout='${targetLayout}'";

    paletteForMode = currentMode:
      if currentMode == "dark"
      then "harddark"
      else "softlight";

    wallust = lib.getExe pkgs.wallust;
    swayncClient = "${pkgs.swaynotificationcenter}/bin/swaync-client";

    waybarTemplate = ''
      @define-color cursor {{cursor}};
      @define-color background {{background}};
      @define-color foreground {{foreground}};
      @define-color color0  {{color0 }};
      @define-color color1  {{color1 }};
      @define-color color2  {{color2 }};
      @define-color color3  {{color3 }};
      @define-color color4  {{color4 }};
      @define-color color5  {{color5 }};
      @define-color color6  {{color6 }};
      @define-color color7  {{color7 }};
      @define-color color8  {{color8 }};
      @define-color color9  {{color9 }};
      @define-color color10 {{color10}};
      @define-color color11 {{color11}};
      @define-color color12 {{color12}};
      @define-color color13 {{color13}};
      @define-color color14 {{color14}};
      @define-color color15 {{color15}};
    '';

    niriTemplate = ''
      layout {
          focus-ring {
              active-color "{{color4}}"
              inactive-color "{{color8}}"
              urgent-color "{{color1}}"
          }
      }
    '';
  in {
    programs.wallust = {
      enable = true;
      package = pkgs.wallust;
      settings = {
        backend = "full";
        color_space = "lch";
        fallback_generator = "complementary";
        palette = paletteForMode mode;

        templates = {
          waybar = {
            template = "waybar.css";
            target = "~/.config/waybar/colors.css";
          };

          swaync = {
            template = "swaync.css";
            target = "~/.config/swaync/colors.css";
          };

          niri = {
            template = "niri.kdl";
            target = "~/.config/niri/wallust.kdl";
          };
        };
      };
    };

    home.packages = [
      (pkgs.writeShellScriptBin "theme-from-wallpaper-dark" ''
        ${wallust} run --palette harddark ${lib.escapeShellArg (toString selectedWallpaper)}
        if command -v niri >/dev/null 2>&1; then
          niri msg action load-config-file || true
        fi
        ${swayncClient} -R || true
      '')
      (pkgs.writeShellScriptBin "theme-from-wallpaper-light" ''
        ${wallust} run --palette softlight ${lib.escapeShellArg (toString selectedWallpaper)}
        if command -v niri >/dev/null 2>&1; then
          niri msg action load-config-file || true
        fi
        ${swayncClient} -R || true
      '')
    ];

    xdg.configFile = {
      "wallust/templates/niri.kdl".text = niriTemplate;
      "wallust/templates/waybar.css".text = waybarTemplate;
      "wallust/templates/swaync.css".text = waybarTemplate;
      "niri/wallust.kdl".text = ''
        layout {
            focus-ring {
                active-color "#729fcf"
                inactive-color "#586e75"
                urgent-color "#ef2929"
            }
        }
      '';
    };

    systemd.user.services.wallust-apply = {
      Unit = {
        Description = "Apply wallust colorscheme";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "wallust-apply" ''
          set -e
          ${wallust} run --palette ${paletteForMode mode} ${lib.escapeShellArg (toString selectedWallpaper)}
          if command -v niri >/dev/null 2>&1; then
            niri msg action reload-config || true
          fi
          ${swayncClient} -R || true
        '';
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
