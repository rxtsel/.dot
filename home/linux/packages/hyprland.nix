{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
        "$mod" = "SUPER";
        "$terminal" = "ghostty";
        "$fileManager" = "yazi";
        "$menu" = "wofi --show drun";
        "$browser" = "brave";

        monitor = [
          "DP-1, highrr, auto-left, 1"
          "DP-2, highrr, 0x0, 1"
        ];

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
          # "$mod SHIFT, S, exec, ~/grim.sh"
          # "$mod SHIFT, z, exec, ~/wallpapers.sh"
          # "$mod, P, pseudo," # dwindl
          # "$mod, J, toggleSplit," # dwindle

          # Switch workspaces with mainMod + [0-9]
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

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
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

          # Scroll through existing workspaces with mainMod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        exec-once = [
          "dbus-update-activation-environment --systemd DISPLAY XAUTHORITY WAYLAND_DISPLAY XDG_SESSION_DESKTOP=Hyprland XDG_CURRENT_DESKTOP=Hyprland XDG_SESSION_TYPE=wayland"
          "waybar"
        ];

        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "GDK_BACKEND,wayland"
        ];

        input = {
          kb_layout = "us";
          kb_variant = "dvorak";
        };
      };
  };
}
