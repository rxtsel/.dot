{
  flake.nixosModules.notificationsService =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
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
      options.notifications.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Sway Notification Center";
      };

      config = lib.mkIf config.notifications.enable {
        environment.systemPackages = with pkgs; [
          swaynotificationcenter
          libnotify
        ];

        # Systemd user service
        systemd.user.services.swaync = {
          description = "Sway Notification Center";
          after = [ "graphical-session.target" ];
          partOf = [ "graphical-session.target" ];

          serviceConfig = {
            ExecStartPre = pkgs.writeShellScript "swaync-prepare-colors" ''
              set -eu

              if [ ! -f "$HOME/.config/swaync/colors.css" ]; then
                install -d "$HOME/.config/swaync"
                install -Dm644 ${wallustFallbackColors} "$HOME/.config/swaync/colors.css"
              fi
            '';
            ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
            Restart = "on-failure";
          };

          enable = true;
        };
      };
    };
}
