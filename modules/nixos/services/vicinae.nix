{
  flake.nixosModules.vicinae =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.services.vicinae-custom;
    in
    {
      options.services.vicinae-custom = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Vicinae launcher server";
        };
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = [ pkgs.vicinae ];

        systemd.user.services.vicinae = {
          description = "Vicinae Launcher Server Daemon";

          wantedBy = [ "graphical-session.target" ];
          partOf = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];

          serviceConfig = {
            ExecStart = "${lib.getExe pkgs.vicinae} server";
            Restart = "on-failure";
            RestartSec = 2;
          };

          environment = {
            USE_LAYER_SHELL = "1";
          };

          enable = true;
        };
      };
    };
}
