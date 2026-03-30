{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niriLaptop;
      };
    };

  perSystem =
    { pkgs, lib, ... }:
    {

      packages.niriLaptop = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        settings = {
          spawn-at-startup = [
            "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=GNOME"
          ];

          environment = {
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "qt6ct";
            QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
          };
          input = {
            workspace-auto-back-and-forth = { };
            keyboard = {
              xkb = {
                layout = "us";
                variant = "dvorak-intl";
              };
            };

            touchpad = {
              natural-scroll = { };
              tap = { };
            };
          };

          layout = {
            gaps = 4;
            always-center-single-column = { };
            center-focused-column = "always";
            default-column-display = "tabbed";
            default-column-width = {
              proportion = 0.5;
            };
            background-color = "transparent";
            preset-column-widths = {
              proportion = 0.5;
            };

            preset-window-heights = {
              proportion = 0.5;
            };

            focus-ring = {
              width = 1.5;
              active-color = "#268bd3";
              inactive-color = "#586e75";
              urgent-color = "#f55350";
            };

            border = {
              off = { };
              width = 0;
            };

            tab-indicator = {
              hide-when-single-tab = { };
              place-within-column = { };
            };

            struts = {
              top = 0;
              bottom = 0;
              left = 0;
              right = 0;
            };
          };

          prefer-no-csd = { };

          hotkey-overlay = {
            skip-at-startup = { };
          };

          binds = {
            "Mod+T".spawn-sh = lib.getExe pkgs.ghostty;
            "Mod+B".spawn-sh = lib.getExe pkgs.brave;
            "Mod+E".spawn-sh = "ghostty -e yazi";
            "Mod+Space".spawn = lib.getExe pkgs.vicinae;
            "Super+Alt+L".spawn = lib.getExe pkgs.swaylock;
            "Super+Alt+S".spawn-sh = "pkill orca || exec orca";
            "Mod+Q".close-window = { };
            "Mod+F".maximize-column = { };
            "Mod+Shift+F".fullscreen-window = { };
            "Mod+C".center-column = { };
            "Mod+O".toggle-overview = { };
            "Mod+BracketLeft".consume-or-expel-window-left = { };
            "Mod+BracketRight".consume-or-expel-window-right = { };
            "Mod+Comma".consume-window-into-column = { };
            "Mod+Period".expel-window-from-column = { };
            "Mod+R".switch-preset-column-width = { };
            "Mod+Shift+R".switch-preset-window-height = { };
            "Mod+Ctrl+R".reset-window-height = { };
            "Mod+Ctrl+F".expand-column-to-available-width = { };
            "Mod+Ctrl+C".center-visible-columns = { };
            "Mod+Minus".set-column-width = "-10%";
            "Mod+Equal".set-column-width = "+10%";
            "Mod+Shift+Minus".set-window-height = "-10%";
            "Mod+Shift+Equal".set-window-height = "+10%";
            "Mod+V".toggle-window-floating = { };
            "Mod+Shift+V".switch-focus-between-floating-and-tiling = { };
            "Mod+W".toggle-column-tabbed-display = { };
            "Mod+Shift+S".screenshot = { };
            "Mod+Escape".toggle-keyboard-shortcuts-inhibit = { };
            "Ctrl+Alt+Delete".quit = { };
            # Powers off the monitors. To turn them back on, do any input like
            "Mod+Shift+P".power-off-monitors = { };
            "Mod+N".spawn-sh = "swaync-client  -t";

            # Volume keys mappings for PipeWire & WirePlumber.
            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.1+";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.1-";
            "XF86AudioMute".spawn-sh = "wpctl set-mute -l 1.0 @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioMicMute".spawn-sh = "wpctl set-mute -l 1.0 @DEFAULT_AUDIO_SOURCE@ toggle";

            # This will work with any MPRIS-enabled media player.
            "XF86AudioPlay".spawn-sh = "playerctl play-pause";
            "XF86AudioStop".spawn-sh = "playerctl stop";
            "XF86AudioPrev".spawn-sh = "playerctl previous";
            "XF86AudioNext".spawn-sh = "playerctl next";

            # Brightness key mappings for brightnessctl.
            "XF86MonBrightnessUp".spawn-sh = "brightnessctl --class=backlight set +10%";
            "XF86MonBrightnessDown".spawn-sh = "brightnessctl --class=backlight set 10%-";

            "Mod+Left".focus-column-left = { };
            "Mod+Down".focus-window-down = { };
            "Mod+Up".focus-window-up = { };
            "Mod+Right".focus-column-right = { };
            "Mod+H".focus-column-left = { };
            "Mod+J".focus-window-down = { };
            "Mod+K".focus-window-up = { };
            "Mod+L".focus-column-right = { };

            "Mod+Shift+H".move-column-left = { };
            "Mod+Shift+L".move-column-right = { };
            "Mod+Shift+K".move-window-up = { };
            "Mod+Shift+J".move-window-down = { };
            "Mod+Shift+Left".move-column-left = { };
            "Mod+Shift+Down".move-window-down = { };
            "Mod+Shift+Up".move-window-up = { };
            "Mod+Shift+Right".move-column-right = { };

            "Mod+Home".focus-column-first = { };
            "Mod+End".focus-column-last = { };
            "Mod+Ctrl+Home".move-column-to-first = { };
            "Mod+Ctrl+End".move-column-to-last = { };

            "Mod+Ctrl+Left".focus-monitor-left = { };
            "Mod+Ctrl+Down".focus-monitor-down = { };
            "Mod+Ctrl+Up".focus-monitor-up = { };
            "Mod+Ctrl+Right".focus-monitor-right = { };
            "Mod+Ctrl+H".focus-monitor-left = { };
            "Mod+Ctrl+J".focus-monitor-down = { };
            "Mod+Ctrl+K".focus-monitor-up = { };
            "Mod+Ctrl+L".focus-monitor-right = { };

            "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = { };
            "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = { };
            "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = { };
            "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = { };
            "Mod+Shift+Ctrl+H".move-column-to-monitor-left = { };
            "Mod+Shift+Ctrl+J".move-column-to-monitor-down = { };
            "Mod+Shift+Ctrl+K".move-column-to-monitor-up = { };
            "Mod+Shift+Ctrl+L".move-column-to-monitor-right = { };

            "Mod+Page_Down".focus-workspace-down = { };
            "Mod+Page_Up".focus-workspace-up = { };
            "Mod+U".focus-workspace-down = { };
            "Mod+I".focus-workspace-up = { };
            "Mod+Ctrl+Page_Down".move-column-to-workspace-down = { };
            "Mod+Ctrl+Page_Up".move-column-to-workspace-up = { };
            "Mod+Ctrl+U".move-column-to-workspace-down = { };
            "Mod+Ctrl+I".move-column-to-workspace-up = { };

            "Mod+Shift+Page_Down".move-workspace-down = { };
            "Mod+Shift+Page_Up".move-workspace-up = { };
            "Mod+Shift+U".move-workspace-down = { };
            "Mod+Shift+I".move-workspace-up = { };

            "Mod+WheelScrollDown".focus-workspace-down = { };
            "Mod+WheelScrollUp".focus-workspace-up = { };
            "Mod+Ctrl+WheelScrollDown".move-column-to-workspace-down = { };
            "Mod+Ctrl+WheelScrollUp".move-column-to-workspace-up = { };

            "Mod+WheelScrollRight".focus-column-right = { };
            "Mod+WheelScrollLeft".focus-column-left = { };
            "Mod+Ctrl+WheelScrollRight".move-column-right = { };
            "Mod+Ctrl+WheelScrollLeft".move-column-left = { };

            "Mod+Shift+WheelScrollDown".focus-column-right = { };
            "Mod+Shift+WheelScrollUp".focus-column-left = { };
            "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = { };
            "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = { };

            "Mod+1".focus-workspace = "code";
            "Mod+2".focus-workspace = "browser";
            "Mod+3".focus-workspace = "explorer";
            "Mod+4".focus-workspace = "music";
            "Mod+5".focus-workspace = "social";
            "Mod+6".focus-workspace = "email";
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;

            "Mod+Ctrl+1".move-column-to-workspace = "code";
            "Mod+Ctrl+2".move-column-to-workspace = "browser";
            "Mod+Ctrl+3".move-column-to-workspace = "explorer";
            "Mod+Ctrl+4".move-column-to-workspace = "music";
            "Mod+Ctrl+5".move-column-to-workspace = "social";
            "Mod+Ctrl+6".move-column-to-workspace = "email";
            "Mod+Ctrl+7".move-column-to-workspace = 7;
            "Mod+Ctrl+8".move-column-to-workspace = 8;
            "Mod+Ctrl+9".move-column-to-workspace = 9;
          };

          workspaces = {
            code = {
              open-on-output = "eDP-1";
            };
            browser = {
              open-on-output = "eDP-1";
            };
            explorer = {
              open-on-output = "eDP-1";
            };
            music = {
              open-on-output = "eDP-1";
            };
            social = {
              open-on-output = "eDP-1";
            };
            email = {
              open-on-output = "eDP-1";
            };
          };
        };
      };
    };
}
