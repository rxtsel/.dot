{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        exclusive = true;
        mode = "dock";
        spacing = 11;

        modules-left =
          [ "custom/launcher" "hyprland/workspaces" "group/quicklinks" ];
        modules-center = [ ];
        modules-right = [
          "tray"
          "bluetooth"
          "pulseaudio"
          "network"
          "custom/exit"
          "group/hardware"
          "hyprland/language"
          "clock"
        ];

        "group/quicklinks" = {
          orientation = "horizontal";
          modules = [ "custom/aichat" "custom/music" ];
        };

        "group/hardware" = {
          orientation = "horizontal";
          modules = [ "disk" "cpu" "memory" ];
        };

        # Custom
        "hyprland/workspaces" = {
          on-click = "activate";
          active-only = false;
          all-outputs = true;
          format = "{}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
        };

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 24;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = [ "kitty" ];
          app_ids-mapping = { chromium = "chromium-browser"; };
          rewrite = {
            "Firefox Web Browser" = "Firefox";
            "Chromium" = "Chromium";
            "Foot Server" = "Terminal";
          };
        };

        "hyprland/window" = {
          rewrite = {
            "(.*) - Brave" = "$1";
            "(.*) - Chromium" = "$1";
            "(.*) - Brave Search" = "$1";
          };
          separate-outputs = true;
        };

        tray = {
          icon-size = 16;
          spacing = 14;
        };

        clock = {
          format = "{:%a %d %B %H:%M}";
          tooltip = false;
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        cpu = {
          format = " CPU {usage}% ";
          on-click = "ghostty -e btop";
        };

        memory = { format = " MEM {}% "; };

        disk = { format = "DISK {percentage_used}% "; };

        network = {
          "format-wifi" = " ";
          "format-ethernet" = "󱘖";
          "tooltip-format" = "󰤪    {essid}";
          "format-linked" = "󱘖   {ifname} (No IP)";
          "format-disconnected" = "󰤭";
          interval = 5;
          tooltip = true;
          "icon-size" = 24;
        };

        pulseaudio = {
          format = "{icon}";
          "format-muted" = "󰝟";
          "on-click" = "pavucontrol -t 3";
          "on-scroll-up" = "pamixer -i 5";
          "on-scroll-down" = "pamixer -d 5";
          "tooltip-format" = "{volume}%";
          "scroll-step" = 5;
          "format-icons" = {
            headphone = "";
            "hands-free" = "";
            headset = "";
            default = [ " " " " " " ];
          };
          "icon-size" = 24;
        };

        bluetooth = {
          format = "";
          "format-disabled" = "󰂲";
          "format-connected" = "󰂯";
          "on-click" = "ghostty -e bluetui";
          "tooltip-format" = "{device_alias}";
          "tooltip-format-connected" = "{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}";
          "icon-size" = 24;
        };

        user = {
          format = "{user}";
          interval = 60;
          icon = false;
          "icon-size" = 24;
        };

        "hyprland/language" = {
          format = "{}";
          "format-en" = "DV";
          "format-es" = "SP";
        };

        "custom/launcher" = {
          format = " ";
          tooltip = false;
          "on-click" = "wlogout";
          interval = 3600;
          "icon-size" = 24;
        };

      };
    };

    style = ./style.css;
  };
}
