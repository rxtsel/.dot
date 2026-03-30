{
  flake.nixosModules.notifications =
    {
      pkgs,
      lib,
      config,
      ...
    }:
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
            ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
            Restart = "on-failure";
          };

          enable = true;
        };
      };
    };
}
