{ ... }:

{
  # Write Niri config to: ~/.config/niri/config.kdl
  xdg.configFile."niri/config.kdl".text = ''
    // WORKSPACES
    workspace "code" {
      open-on-output "DP-1"
    }
    workspace "browser" {
      open-on-output "DP-2"
    }
    workspace "explorer" {
      open-on-output "DP-1"
    }
    workspace "music" {
      open-on-output "DP-1"
    }
    workspace "social" {
      open-on-output "DP-1"
    }
    workspace "email" {
      open-on-output "DP-1"
    }


    // INPUT
    input {
      workspace-auto-back-and-forth
      focus-follows-mouse
      keyboard {
        xkb {
          layout "us"
          variant "dvorak-intl"
          options "lv3:ralt-switch"
        }
      }
    }


    // MONITORS
    output "DP-1" {
      mode "2560x1440@144.000"
      scale 1
      transform "normal"
      position x=2560 y=0
      focus-at-startup
    }
    output "DP-2" {
      mode "2560x1440@144.000"
      scale 1
      transform "normal"
      position x=0 y=0
    }


    // LAYOUT
    layout {
      gaps 4
      always-center-single-column
      center-focused-column "always"
      default-column-display "tabbed"
      default-column-width { proportion 0.5; }
      background-color "transparent"
      preset-column-widths {
        proportion 0.5
        proportion 0.66667
      }

      preset-window-heights {
        proportion 0.5
        proportion 1.0
      }

      focus-ring {
        width 1.5
        active-color "#268bd3"
        inactive-color "#586e75"
        urgent-color "#f55350"
      }

      border {
        off
        width 0
      }

      tab-indicator {
        hide-when-single-tab
        place-within-column
      }

      struts {
        top 0
        bottom 0
        left 0
        right 0
      }
    }


    // AUTOSTART
    spawn-at-startup "dbus-update-activation-environment" "--systemd" "DISPLAY WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP=GNOME"
    spawn-at-startup "swaybg" "-o" "DP-1" "-i" "/home/rxtsel/Pictures/wallpaper_1.png" "-m" "fill"
    spawn-at-startup "swaybg" "-o" "DP-2" "-i" "/home/rxtsel/Pictures/wallpaper_0.png" "-m" "fill"
    spawn-at-startup "waybar"

    // Force dvorak intl for x11 apps after a short delay
    spawn-sh-at-startup "sleep 2 && setxkbmap us -variant dvorak-intl"


    hotkey-overlay {
      skip-at-startup
    }


    // Hidden window decorations
    prefer-no-csd


    // ENVIRONMENTS
    environment {
      QT_QPA_PLATFORM "wayland"
      QT_QPA_PLATFORMTHEME "qt6ct"
      QT_QPA_PLATFORMTHEME_QT6 "qt6ct"
    }


    // SCREENSHOTS
    screenshot-path "~/Pictures/screenshots/%Y-%m-%d %H-%M-%S.png"


    // WINDOW RULES
    // Ghostty
    window-rule {
        match app-id=r#"com.mitchellh.ghostty$"#
        open-on-workspace "code"
        open-focused true
    }
    // Zen
    window-rule {
        match app-id=r#"zen-twilight$"# title="^Picture-in-Picture$"
        open-floating true
    }
    window-rule {
        match app-id=r#"zen-twilight$"#
        open-maximized true
        open-on-workspace "browser"
    }
    // Add rounded corners
    window-rule {
        geometry-corner-radius 8
        clip-to-geometry true
    }
    // Thunderbird
    window-rule {
        match app-id=r#"^org\.mozilla\.Thunderbird$"#
        open-on-workspace "email"
        open-maximized true
        open-focused false
        block-out-from "screencast"
    }
    // Discord
    window-rule {
        match app-id=r#"discord$"#
        open-on-workspace "social"
        open-focused false
        open-floating true
        default-window-height { proportion 0.5; }
        default-column-width { proportion 0.5; }
        default-floating-position x=0 y=0 relative-to="top-right"
        block-out-from "screencast"
    }
    // Youtube music
    window-rule {
        match app-id=r#"^com\.github\.th_ch\.youtube_music$"#
        open-on-workspace "social"
        open-focused false
        open-floating true
        default-window-height { proportion 0.5; }
        default-column-width { proportion 0.5; }
        default-floating-position x=0 y=0 relative-to="bottom-left"
    }
    // ResponsivelyApp
    window-rule {
      match app-id=r#"ResponsivelyApp$"#
      open-fullscreen true
      open-on-workspace "browser"
    }


    // LAYER RULES
    // Keep wallpaper in background
    layer-rule {
        match namespace="^wallpaper$"
        place-within-backdrop true
    }


    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+T hotkey-overlay-title="Open a Terminal: Ghostty" { spawn "ghostty"; }
        // Mod+Space hotkey-overlay-title="Run an Application: vicinae" { spawn "vicinae" "toggle"; }
        Super+E hotkey-overlay-title="Open a file explorer: Yazi" { spawn-sh "ghostty -e yazi"; }
        Super+Alt+L hotkey-overlay-title="Lock the Screen: swaylock" { spawn "swaylock"; }
        Mod+B hotkey-overlay-title="Open Browser" { spawn "zen"; }

        Super+Alt+S allow-when-locked=true hotkey-overlay-title=null { spawn-sh "pkill orca || exec orca"; }

        // Volume keys mappings for PipeWire & WirePlumber.
        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.1+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute -l 1.0 @DEFAULT_AUDIO_SINK@ toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute -l 1.0 @DEFAULT_AUDIO_SOURCE@ toggle"; }

        // This will work with any MPRIS-enabled media player.
        XF86AudioPlay        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        XF86AudioStop        allow-when-locked=true { spawn-sh "playerctl stop"; }
        XF86AudioPrev        allow-when-locked=true { spawn-sh "playerctl previous"; }
        XF86AudioNext        allow-when-locked=true { spawn-sh "playerctl next"; }

        // Brightness key mappings for brightnessctl.
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }

        // Open/close the Overview: a zoomed-out view of workspaces and windows.
        Mod+O repeat=false { toggle-overview; }
        Mod+Q repeat=false { close-window; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Up    { move-window-up; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+H     { move-column-left; }
        Mod+Ctrl+J     { move-window-down; }
        Mod+Ctrl+K     { move-window-up; }
        Mod+Ctrl+L     { move-column-right; }

        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Shift+Left  { focus-monitor-left; }
        Mod+Shift+Down  { focus-monitor-down; }
        Mod+Shift+Up    { focus-monitor-up; }
        Mod+Shift+Right { focus-monitor-right; }
        Mod+Shift+H     { focus-monitor-left; }
        Mod+Shift+J     { focus-monitor-down; }
        Mod+Shift+K     { focus-monitor-up; }
        Mod+Shift+L     { focus-monitor-right; }

        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }
        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }

        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        Mod+1 { focus-workspace "code"; }
        Mod+2 { focus-workspace "browser"; }
        Mod+3 { focus-workspace "explorer"; }
        Mod+4 { focus-workspace "music"; }
        Mod+5 { focus-workspace "social"; }
        Mod+6 { focus-workspace "email"; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace "code"; }
        Mod+Ctrl+2 { move-column-to-workspace "browser"; }
        Mod+Ctrl+3 { move-column-to-workspace "explorer"; }
        Mod+Ctrl+4 { move-column-to-workspace "music"; }
        Mod+Ctrl+5 { move-column-to-workspace "social"; }
        Mod+Ctrl+6 { move-column-to-workspace "email"; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }

        Mod+Ctrl+F { expand-column-to-available-width; }

        Mod+C { center-column; }

        Mod+Ctrl+C { center-visible-columns; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+V       { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }

        Mod+W { toggle-column-tabbed-display; }

        Mod+Shift+S { screenshot; }

        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        Ctrl+Alt+Delete { quit; }

        // Powers off the monitors. To turn them back on, do any input like
        Mod+Shift+P { power-off-monitors; }
    }

    xwayland-satellite {
        path "xwayland-satellite"
    }
  '';
}

