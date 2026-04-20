{inputs, ...}: {
  flake.modules.nixos.niri = {
    pkgs,
    lib,
    config,
    ...
  }: let
    cfg = config.my.host;

    # Sort: non-primary first (left), primary last (right)
    sortedMonitors = lib.sort (a: b: (!a.primary) && b.primary) cfg.monitors;

    # Accumulate X positions left-to-right
    monitorPositions =
      lib.foldl' (
        acc: monitor: {
          currentX = acc.currentX + monitor.width;
          entries =
            acc.entries
            ++ [
              {
                inherit monitor;
                x = acc.currentX;
              }
            ];
        }
      ) {
        currentX = 0;
        entries = [];
      }
      sortedMonitors;

    dynamicOutputsConfig =
      lib.concatMapStrings (entry: let
        m = entry.monitor;
        modeStr = "${toString m.width}x${toString m.height}@${toString m.refresh}.000";
      in ''
        output "${m.name}" {
          mode "${modeStr}"
          scale 1
          transform "normal"
          position x=${toString entry.x} y=0
          ${lib.optionalString m.primary "focus-at-startup"}
        }
      '')
      monitorPositions.entries;

    primaryMonitor = lib.findFirst (m: m.primary) null cfg.monitors;
    secondaryMonitor = lib.findFirst (m: !m.primary) null cfg.monitors;

    dynamicWorkspacesConfig = let
      primary =
        if primaryMonitor != null
        then primaryMonitor.name
        else null;
      secondary =
        if secondaryMonitor != null
        then secondaryMonitor.name
        else null;

      mkWorkspace = name: outputName: ''
        workspace "${name}" {
          ${lib.optionalString (outputName != null) ''open-on-output "${outputName}"''}
        }
      '';
    in
      lib.concatStrings [
        (mkWorkspace "1:code" primary)
        (mkWorkspace "2:browser" secondary)
        (mkWorkspace "3:explorer" primary)
        (mkWorkspace "4:music" primary)
        (mkWorkspace "5:social" primary)
        (mkWorkspace "6:email" primary)
      ];

    niriPackage = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      settings = {
        extraConfig = ''
          include optional=true "~/.config/niri/wallust.kdl"
          ${dynamicOutputsConfig}
          ${dynamicWorkspacesConfig}
        '';

        environment = {
          QT_QPA_PLATFORM = "wayland";
          QT_QPA_PLATFORMTHEME = "qt6ct";
          QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
        };

        input = {
          workspace-auto-back-and-forth = {};
          keyboard = {
            xkb = {
              layout = "us";
              variant = "dvorak-intl";
            };
          };
          touchpad = {
            natural-scroll = {};
            tap = {};
          };
        };

        inherit (buildLayout) layout;

        prefer-no-csd = {};
        hotkey-overlay.skip-at-startup = {};

        blur = {
          passes = 3;
          offset = 3.0;
          noise = 0.02;
          saturation = 1.5;
        };

        inherit (buildWindowRules) window-rules layer-rules;

        overview.workspace-shadow.off = {};

        binds = baseBinds // lib.optionalAttrs cfg.features.ddcci ddcciBinds;
      };
    };

    # ── binds ────────────────────────────────────────────────────────────────
    baseBinds = {
      "Mod+T".spawn = lib.getExe pkgs.ghostty;
      "Mod+B".spawn = lib.getExe pkgs.brave;
      "Mod+E".spawn-sh = "${lib.getExe pkgs.ghostty} -e yazi";
      "Mod+Space".spawn-sh = "${lib.getExe pkgs.vicinae} toggle";
      "Super+Alt+L".spawn = lib.getExe pkgs.swaylock;
      "Super+Alt+S".spawn-sh = "pkill orca || exec orca";
      "Mod+Q".close-window = {};
      "Mod+F".maximize-column = {};
      "Mod+Shift+F".fullscreen-window = {};
      "Mod+C".center-column = {};
      "Mod+O".toggle-overview = {};
      "Mod+BracketLeft".consume-or-expel-window-left = {};
      "Mod+BracketRight".consume-or-expel-window-right = {};
      "Mod+Comma".consume-window-into-column = {};
      "Mod+Period".expel-window-from-column = {};
      "Mod+R".switch-preset-column-width = {};
      "Mod+Shift+R".switch-preset-window-height = {};
      "Mod+Ctrl+R".reset-window-height = {};
      "Mod+Ctrl+F".expand-column-to-available-width = {};
      "Mod+Ctrl+C".center-visible-columns = {};
      "Mod+Minus".set-column-width = "-10%";
      "Mod+Equal".set-column-width = "+10%";
      "Mod+Shift+Minus".set-window-height = "-10%";
      "Mod+Shift+Equal".set-window-height = "+10%";
      "Mod+V".toggle-window-floating = {};
      "Mod+Shift+V".switch-focus-between-floating-and-tiling = {};
      "Mod+W".toggle-column-tabbed-display = {};
      "Mod+Shift+S".screenshot = {};
      "Mod+Escape".toggle-keyboard-shortcuts-inhibit = {};
      "Ctrl+Alt+Delete".quit = {};
      "Mod+Shift+P".power-off-monitors = {};
      "Mod+N".spawn-sh = "swaync-client -t";

      "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.1+";
      "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.1-";
      "XF86AudioMute".spawn-sh = "wpctl set-mute -l 1.0 @DEFAULT_AUDIO_SINK@ toggle";
      "XF86AudioMicMute".spawn-sh = "wpctl set-mute -l 1.0 @DEFAULT_AUDIO_SOURCE@ toggle";

      "XF86AudioPlay".spawn-sh = "playerctl play-pause";
      "XF86AudioStop".spawn-sh = "playerctl stop";
      "XF86AudioPrev".spawn-sh = "playerctl previous";
      "XF86AudioNext".spawn-sh = "playerctl next";

      # Default brightness binds (overridden by ddcciBinds when ddcci=true)
      "XF86MonBrightnessUp".spawn-sh = "brightnessctl --class=backlight set +10%";
      "XF86MonBrightnessDown".spawn-sh = "brightnessctl --class=backlight set 10%-";

      "Mod+Left".focus-column-left = {};
      "Mod+Down".focus-window-down = {};
      "Mod+Up".focus-window-up = {};
      "Mod+Right".focus-column-right = {};
      "Mod+H".focus-column-left = {};
      "Mod+J".focus-window-down = {};
      "Mod+K".focus-window-up = {};
      "Mod+L".focus-column-right = {};

      "Mod+Shift+H".move-column-left = {};
      "Mod+Shift+L".move-column-right = {};
      "Mod+Shift+K".move-window-up = {};
      "Mod+Shift+J".move-window-down = {};
      "Mod+Shift+Left".move-column-left = {};
      "Mod+Shift+Down".move-window-down = {};
      "Mod+Shift+Up".move-window-up = {};
      "Mod+Shift+Right".move-column-right = {};

      "Mod+Home".focus-column-first = {};
      "Mod+End".focus-column-last = {};
      "Mod+Ctrl+Home".move-column-to-first = {};
      "Mod+Ctrl+End".move-column-to-last = {};

      "Mod+Ctrl+Left".focus-monitor-left = {};
      "Mod+Ctrl+Down".focus-monitor-down = {};
      "Mod+Ctrl+Up".focus-monitor-up = {};
      "Mod+Ctrl+Right".focus-monitor-right = {};
      "Mod+Ctrl+H".focus-monitor-left = {};
      "Mod+Ctrl+J".focus-monitor-down = {};
      "Mod+Ctrl+K".focus-monitor-up = {};
      "Mod+Ctrl+L".focus-monitor-right = {};

      "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = {};
      "Mod+Shift+Ctrl+H".move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+J".move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+K".move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+L".move-column-to-monitor-right = {};

      "Mod+Page_Down".focus-workspace-down = {};
      "Mod+Page_Up".focus-workspace-up = {};
      "Mod+U".focus-workspace-down = {};
      "Mod+I".focus-workspace-up = {};
      "Mod+Ctrl+Page_Down".move-column-to-workspace-down = {};
      "Mod+Ctrl+Page_Up".move-column-to-workspace-up = {};
      "Mod+Ctrl+U".move-column-to-workspace-down = {};
      "Mod+Ctrl+I".move-column-to-workspace-up = {};

      "Mod+Shift+Page_Down".move-workspace-down = {};
      "Mod+Shift+Page_Up".move-workspace-up = {};
      "Mod+Shift+U".move-workspace-down = {};
      "Mod+Shift+I".move-workspace-up = {};

      "Mod+WheelScrollDown".focus-workspace-down = {};
      "Mod+WheelScrollUp".focus-workspace-up = {};
      "Mod+Ctrl+WheelScrollDown".move-column-to-workspace-down = {};
      "Mod+Ctrl+WheelScrollUp".move-column-to-workspace-up = {};

      "Mod+WheelScrollRight".focus-column-right = {};
      "Mod+WheelScrollLeft".focus-column-left = {};
      "Mod+Ctrl+WheelScrollRight".move-column-right = {};
      "Mod+Ctrl+WheelScrollLeft".move-column-left = {};

      "Mod+Shift+WheelScrollDown".focus-column-right = {};
      "Mod+Shift+WheelScrollUp".focus-column-left = {};
      "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = {};
      "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = {};

      "Mod+1".focus-workspace = "1:code";
      "Mod+2".focus-workspace = "2:browser";
      "Mod+3".focus-workspace = "3:explorer";
      "Mod+4".focus-workspace = "4:music";
      "Mod+5".focus-workspace = "5:social";
      "Mod+6".focus-workspace = "6:email";
      "Mod+7".focus-workspace = 7;
      "Mod+8".focus-workspace = 8;
      "Mod+9".focus-workspace = 9;

      "Mod+Ctrl+1".move-column-to-workspace = "1:code";
      "Mod+Ctrl+2".move-column-to-workspace = "2:browser";
      "Mod+Ctrl+3".move-column-to-workspace = "3:explorer";
      "Mod+Ctrl+4".move-column-to-workspace = "4:music";
      "Mod+Ctrl+5".move-column-to-workspace = "5:social";
      "Mod+Ctrl+6".move-column-to-workspace = "6:email";
      "Mod+Ctrl+7".move-column-to-workspace = 7;
      "Mod+Ctrl+8".move-column-to-workspace = 8;
      "Mod+Ctrl+9".move-column-to-workspace = 9;
    };

    ddcciBinds = {
      "XF86MonBrightnessUp".spawn-sh = "ddcutil setvcp 10 + 10";
      "XF86MonBrightnessDown".spawn-sh = "ddcutil setvcp 10 - 10";
    };

    # ── layout ───────────────────────────────────────────────────────────────
    buildLayout = {
      layout = {
        gaps = 4;
        always-center-single-column = {};
        center-focused-column = "always";
        default-column-display = "tabbed";
        default-column-width.proportion = 0.5;
        background-color = "transparent";
        preset-column-widths = [
          {proportion = 0.5;}
          {proportion = 0.666667;}
        ];
        preset-window-heights = [
          {proportion = 0.5;}
          {proportion = 0.1;}
        ];
        focus-ring = {
          width = 1.5;
          active-color = "#729fcf";
          inactive-color = "#586e75";
          urgent-color = "#ef2929";
        };
        border = {
          off = {};
          width = 0;
        };
        tab-indicator = {
          hide-when-single-tab = {};
          place-within-column = {};
        };
        struts = {
          top = 0;
          bottom = 0;
          left = 0;
          right = 0;
        };
      };
    };

    # ── window rules ─────────────────────────────────────────────────────────
    buildWindowRules = {
      window-rules = [
        {
          geometry-corner-radius = 8;
          clip-to-geometry = true;
        }
        {
          matches = [{app-id = "^com\\.mitchellh\\.ghostty$";}];
          background-effect.blur = true;
          open-on-workspace = "1:code";
          open-focused = true;
        }
        {
          matches = [{app-id = "brave-browser";} {app-id = "^ResponsivelyApp$";}];
          open-on-workspace = "2:browser";
        }
        {
          matches = [{app-id = "brave-browser$";}];
          open-focused = true;
          open-maximized = true;
        }
        {
          matches = [{app-id = "^ResponsivelyApp$";}];
          open-fullscreen = true;
        }
        {
          matches = [{title = "^Yazi$";}];
          open-maximized = true;
          open-on-workspace = "3:explorer";
        }
        {
          matches = [
            {app-id = "^com\\.github\\.th_ch\\.youtube_music$";}
            {title = "^YouTube Music$";}
          ];
          open-on-workspace = "4:music";
          open-focused = true;
          open-floating = true;
          default-window-height.proportion = 0.5;
          default-column-width.proportion = 0.5;
        }
        {
          matches = [{app-id = "^com\\.discord$";}];
          open-on-workspace = "5:social";
          open-focused = true;
          open-floating = true;
          default-window-height.proportion = 0.5;
          default-column-width.proportion = 0.5;
        }
        {
          matches = [{app-id = "^Clockify$";}];
          open-fullscreen = false;
          open-floating = true;
          open-on-workspace = "5:social";
        }
        {
          matches = [{app-id = "^com\\.thunderbird$";}];
          open-on-workspace = "6:email";
          open-maximized = true;
          open-focused = false;
          block-out-from = "screencast";
        }
      ];

      layer-rules = [
        {
          matches = [{namespace = "^awww-daemon$";}];
          place-within-backdrop = true;
        }
      ];
    };
  in {
    environment.systemPackages = lib.optionals cfg.features.ddcci [pkgs.ddcutil];

    programs.niri = {
      enable = true;
      package = niriPackage;
    };
  };
}
