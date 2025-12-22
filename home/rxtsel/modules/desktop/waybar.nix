{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 0;
        margin-bottom = 0;
        height = 32;
        exclusive = true;
        mode = "dock";
        spacing = 11;

        modules-left = [
          "niri/workspaces"
        ];

        modules-center = [ ];

        modules-right = [
          "tray"
          "bluetooth"
          "pulseaudio"
          "network"
          "group/hardware"
          "clock"
          "custom/notification"
        ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            code = "";
            browser = "";
            explorer = "";
			      music = "";
            social = "";
            email = "";
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
          format-wifi = "󰖩";
          format-ethernet = "󰌗";
          tooltip-format = "󰌗  {ifname}";
          format-linked = "󱚿 {essid} (No IP)";
          format-disconnected = "󰖪";
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
            default = [ "" "" "" ];
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
      };
    };

    style = ''
      /* --- colors.css (inlined) --- */
      @define-color cursor #DC322F;

      @define-color background #002B36;
      @define-color foreground #EEE8D5;

      @define-color color0  #002B36;
      @define-color color1  #DC322F;
      @define-color color2  #859900;
      @define-color color3  #B58900;
      @define-color color4  #268BD2;
      @define-color color5  #D33682;
      @define-color color6  #2AA198;
      @define-color color7  #EEE8D5;

      @define-color color8  #586E75;
      @define-color color9  #DC322F;
      @define-color color10 #859900;
      @define-color color11 #B58900;
      @define-color color12 #268BD2;
      @define-color color13 #D33682;
      @define-color color14 #2AA198;
      @define-color color15 #FDF6E3;


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
        color: @foreground;
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
        background-color: @color1;
      }

      /* -----------------------------------------------------
       * Other
       * ----------------------------------------------------- */
      label:focus {
        background-color: @color0;
      }

      #backlight {
        background-color: @color2;
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
    '';
  };

  # Runtime deps used by your module actions
  home.packages = with pkgs; [
    pavucontrol
    bluetui
    btop
    swaynotificationcenter
    wireplumber
  ];
}

