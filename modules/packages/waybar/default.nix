{ self, inputs, ... }:
{
  flake.nixosModules.waybar =
    { pkgs, ... }:
    {
      systemd.user.services.waybar = {
        description = "Waybar";

        wantedBy = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig = {
          ExecStart = "${self.packages.${pkgs.stdenv.hostPlatform.system}.waybar}/bin/waybar";
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

        "style.css".path = ./style.css;
      };
    };
}
