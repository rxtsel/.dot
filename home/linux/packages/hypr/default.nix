{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "swww-daemon & waybar & swaync & gammastep & thunderbird & discord"
        "~/.dots/home/linux/packages/hypr/scripts/wallpapers.sh"
        "hyprctl dispatch workspace 1"
      ];

      env = [ "HYPRCURSOR_THEME,macOS" "HYPRCURSOR_SIZE,24" ];

      monitor = [ "DP-1, highrr, auto-left, 1" "DP-2, highrr, 0x0, 1" ];

      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$fileManager" = "yazi";
      "$menu" = "wofi --show drun";
      "$browser" = "brave";

      input = {
        kb_layout = "us";
        kb_variant = "dvorak";
      };

      general = {
        gaps_in = 5;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "0x1ee657B83";
        "col.inactive_border" = "rgba(000000aa)";
        resize_on_border = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 4;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        pseudotile = true;
        preserve_split = true; # You probably want this
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, M, exec, wlogout"
        "$mod, E, exec, $terminal -e $fileManager"
        "$mod, V, toggleFloating,"
        "$mod, SPACE, exec, $menu"
        "$mod, B, exec, $browser"
        "$mod, F, fullscreen, 1"
        "$mod SHIFT, M, exec, wlogout"
        "$mod SHIFT, S, exec, ~/.dots/home/linux/packages/hypr/scripts/grim.sh"
        "$mod SHIFT, Z, exec, ~/.dots/home/linux/packages/hypr/scripts/wallpapers.sh"
        "$mod, N, exec, swaync-client -t"
        # "$mod, P, pseudo," # dwindl
        # "$mod, J, toggleSplit," # dwindle

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      layerrule = [
        "blur, waybar"
        "blur, wofi"
        # Swaync
        "blur, ignorezero, ignorealpha 0.5, swaync-control-center"
        "blur, ignorezero, ignorealpha 0.5, swaync-notification-window"
      ];

      windowrule = [
        # Floating windows
        "float, class:org.pulseaudio.pavucontrol"
        "float, class:feh"
        "float, class:mpv"
        "float, class:yaak-app"
        "float, class:DBeaver"
        "float, class:AppleMusic"
        "float, class:Slack"
        "float, class:discord"
        "float, class:Clockify"
        "float, class:ClickUp"

        # Define workspaces and assign applications to them
        "workspace 2, class:Brave-browser"
        "workspace 2, class:Chromium-browser"
        "workspace 3, class:feh"
        "workspace 3, class:mpv"
        "workspace 3, class:yaak-app"
        "workspace 3, class:DBeaver"
        "workspace 4, class:AppleMusic"
        "workspace 5, class:Slack"
        "workspace 5, class:discord"
        "workspace 5, class:ClickUp"
        "workspace 5, class:Clockify"
        "workspace 6, class:thunderbird"

        # Disable border when only one window
        "noborder, onworkspace:w[t1]"
      ];
    };
  };
}
