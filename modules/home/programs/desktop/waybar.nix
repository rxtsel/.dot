{...}: {
  flake.modules.homeManager.waybar = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [
        {
          height = 32;
          layer = "top";
          position = "top";
          margin-top = 0;
          margin-bottom = 0;
          exclusive = true;
          spacing = 11;

          modules-left = ["niri/workspaces"];

          modules-right = [
            "tray"
            "bluetooth"
            "pulseaudio"
            "network"
            "battery"
            "group/hardware"
            "clock"
            "custom/notification"
          ];

          "niri/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1:code" = "";
              "2:browser" = "";
              "3:explorer" = "";
              "4:music" = "";
              "5:social" = "";
              "6:email" = "";
              default = "";
              urgent = "";
            };
          };

          tray = {
            icon-size = 16;
            spacing = 11;
          };

          clock = {
            format = "{:%a %d %B %H:%M}";
          };

          cpu = {
            format = " CPU {usage}% ";
            on-click = "ghostty -e btop";
          };

          memory = {
            format = " MEM {}% ";
          };

          disk = {
            format = "DISK {percentage_used}% ";
          };

          network = {
            format-wifi = "";
            format-ethernet = "󰌗";
            tooltip-format = "󰌗  {ifname}";
            format-linked = " {essid} (No IP)";
            format-disconnected = "";
            interval = 5;
            tooltip = true;
          };

          pulseaudio = {
            format = "{icon}";
            format-muted = "󰝟";
            on-click = "pavucontrol -t 3";
            on-scroll-up = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.05+";
            on-scroll-down = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.05-";
            tooltip-format = "{volume}%";
            scroll-step = 5;
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              default = [
                ""
                ""
                ""
              ];
            };
          };

          bluetooth = {
            format = "";
            format-disabled = "󰂲";
            format-connected = "󰂲";
            on-click = "ghostty -e bluetui";
            tooltip-format = "{device_alias}";
            tooltip-format-connected = "{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}";
          };

          "custom/notification" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };

          "group/hardware" = {
            orientation = "horizontal";
            modules = [
              "disk"
              "cpu"
              "memory"
            ];
          };

          battery = {
            bat = "BAT1";
            interval = 60;
            states = {
              critical = 10;
            };
            format = "{icon}  {capacity}%";
            format-icons = {
              default = [
                "󰂎"
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
              charging = [
                "󰢟"
                "󰢜"
                "󰂆"
                "󰂇"
                "󰂈"
                "󰢝"
                "󰂉"
                "󰢞"
                "󰂊"
                "󰂋"
                "󰂅"
              ];
            };
          };
        }
      ];
      style = ''
        /* --- colors.css (wallust generate) --- */
        @import url("colors.css");


        /* -----------------------------------------------------
         * General
         * ----------------------------------------------------- */
        * {
          font-family: "SF Pro Display", "CaskaydiaCove Nerd Font Propo";
          border: none;
          border-radius: 0;
          font-size: 16px;
          font-weight: 400;
        }

        window#waybar {
          border: none;
          background-color: transparent;
          transition-property: background-color;
          transition-duration: 0.5s;
        }

        /* -----------------------------------------------------
         * Workspaces
         * ----------------------------------------------------- */
        #workspaces {
          background: transparent;
          transition: all 0.5s ease-in-out;
          border: none;
        }

        #workspaces button {
          background-color: transparent;
          transition: all 0.15s ease-in-out;
          color: @foreground;
          opacity: 0.4;
        }

        #workspaces button.active {
          opacity: 1;
          color: @foreground;
        }

        #workspaces button:hover {
          opacity: 1;
          box-shadow: inherit;
          text-shadow: inherit;
          background: none;
          border: none;
        }

        /* -----------------------------------------------------
         * Tooltips
         * ----------------------------------------------------- */
        tooltip {
          border-radius: 4px;
          background-color: @background;
        }

        tooltip label {
          color: @foreground;
        }

        /* -----------------------------------------------------
         * Hardware Group
         * ----------------------------------------------------- */
        #memory,
        #cpu,
        #disk {
          color: @foreground;
          font-weight: 600;
        }

        /* -----------------------------------------------------
         * Clock
         * ----------------------------------------------------- */
        #clock {
          color: @foreground;
          transition: background-color 0.5s ease;
        }

        /* -----------------------------------------------------
         * Pulseaudio
         * ----------------------------------------------------- */
        #pulseaudio {
          background-color: transparent;
          color: @foreground;
        }

        #pulseaudio.muted {
          background-color: transparent;
          color: @color1;
          opacity: 0.4;
        }

        /* -----------------------------------------------------
         * Network
         * ----------------------------------------------------- */
        #network {
          background-color: transparent;
          color: @foreground;
        }

        #network.ethernet {
          background-color: transparent;
          color: @foreground;
        }

        #network.wifi {
          background-color: transparent;
          color: @foreground;
        }

        #network.disabled,
        #network.disconnected {
          background-color: transparent;
          color: @foreground;
          opacity: 0.4;
        }

        /* -----------------------------------------------------
         * Bluetooth
         * ----------------------------------------------------- */
        #bluetooth.on,
        #bluetooth.connected {
          background-color: transparent;
          color: @foreground;
        }

        #bluetooth.off {
          background-color: transparent;
        }

        /* -----------------------------------------------------
         * Tray
         * ----------------------------------------------------- */
        #tray {
          background-color: transparent;
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: transparent;
          color: @color1;
        }

        /* -----------------------------------------------------
         * Other
         * ----------------------------------------------------- */
        label:focus {
          background-color: @color0;
        }

        #network.disconnected {
          background-color: @color1;
        }

        /* -----------------------------------------------------
         * Custom Notification
         * ----------------------------------------------------- */
        #custom-notification {
          color: @foreground;
          margin-right: 14px;
        }

        /* -----------------------------------------------------
         * Battery
         * ----------------------------------------------------- */
        #battery {
          color: @foreground;
          transition: background-color 0.5s ease;
        }
        #battery.charging {
          background-color: transparent;
          color: @color2;
        }
        #battery.warning {
          background-color: transparent;
          color: @color4;
        }
        #battery.critical {
          background-color: transparent;
          color: @color1;
        }
      '';
    };

    home.activation.waybarEnsureColors = ''
            if [ ! -f "$HOME/.config/waybar/colors.css" ]; then
              mkdir -p "$HOME/.config/waybar"
              cat > "$HOME/.config/waybar/colors.css" <<'EOF'
      @define-color cursor #dc322f;
      @define-color background #073642;
      @define-color foreground #fdf6e3;
      @define-color color0  #073642;
      @define-color color1  #dc322f;
      @define-color color2  #859900;
      @define-color color3  #b58900;
      @define-color color4  #268bd2;
      @define-color color5  #d33682;
      @define-color color6  #2aa198;
      @define-color color7  #eee8d5;
      @define-color color8  #6c7c80;
      @define-color color9  #dc322f;
      @define-color color10 #859900;
      @define-color color11 #b58900;
      @define-color color12 #268bd2;
      @define-color color13 #d33682;
      @define-color color14 #2aa198;
      @define-color color15 #eee8d5;
      EOF
            fi
    '';
  };
}
