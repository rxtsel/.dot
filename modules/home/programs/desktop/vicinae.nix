{ lib, ... }:
{
  flake.modules.homeManager.vicinae =
    { pkgs, config, ... }:
    let
      cfg = config.services.vicinae-custom;
    in
    {
      options.services.vicinae-custom.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Vicinae launcher service";
      };

      config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.vicinae ];

        systemd.user.services.vicinae = {
          Unit = {
            Description = "Vicinae Launcher Server Daemon";
            After = [ "graphical-session.target" ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart = "${lib.getExe pkgs.vicinae} server";
            Restart = "on-failure";
            RestartSec = 2;
            Environment = [ "USE_LAYER_SHELL=1" ];
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
}
