{ lib, ... }:
{
  flake.modules.homeManager.gammastep =
    { pkgs, config, ... }:
    let
      vars =
        config._module.args.vars or {
          latitude = "4.6";
          longitude = "-74.0";
        };
      cfg = config.services.gammastep-custom;
    in
    {
      options.services.gammastep-custom.enable = lib.mkEnableOption "Gammastep service";

      config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.gammastep ];

        systemd.user.services.gammastep = {
          Unit = {
            Description = "Gammastep daemon";
            After = [ "graphical-session.target" ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart = ''
              ${lib.getExe pkgs.gammastep} \
                -m wayland \
                -l manual:lat=${vars.latitude}:lon=${vars.longitude} \
                -t 6500:3700 \
                -v
            '';
            Restart = "always";
            RestartSec = 3;
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
}
