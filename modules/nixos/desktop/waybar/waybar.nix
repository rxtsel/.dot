{ self, inputs, ... }:
{
  flake.nixosModules.waybar =
    {
      pkgs,
      config,
      ...
    }:
    let
      username = config.preferences.user.name;
      homeDir = config.users.users.${username}.home;

      wallustFallbackColors = pkgs.writeText "wallust-fallback-colors.css" ''
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
      '';

    in
    {
      systemd.user.services.waybar = {
        description = "Waybar";

        wantedBy = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig = {
          ExecStartPre = pkgs.writeShellScript "waybar-prepare-style" ''
            set -eu

            install -Dm644 ${./style.css} "$HOME/.config/waybar/style.css"

            if [ ! -f "$HOME/.config/waybar/colors.css" ]; then
              install -Dm644 ${wallustFallbackColors} "$HOME/.config/waybar/colors.css"
            fi
          '';

          ExecStart = "${pkgs.waybar}/bin/waybar --config ${self.packages.${pkgs.stdenv.hostPlatform.system}.waybar}/waybar-config.json --style ${homeDir}/.config/waybar/style.css";
          Restart = "on-failure";
        };
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.waybar = inputs.wrapper-modules.wrappers.waybar.wrap {
        inherit pkgs;

        settings = {
          height = 32;
          layer = "top";
          position = "top";
          margin-top = 0;
          margin-bottom = 0;
          exclusive = true;
          spacing = 11;

          modules-left = [ "niri/workspaces" ];

          modules-right = [
            "tray"
            "bluetooth"
            "pulseaudio"
            "network"
            "battery"
            "group/hardware"
            "clock"
            # "custom/notification"
          ];

          "niri/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1:code" = "";
              "2:browser" = "";
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

          "battery" = {
            bat = "BAT1";
            interval = 60;
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
        };

      };
    };
}
