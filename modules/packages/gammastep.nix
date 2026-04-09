{
  flake.nixosModules.gammastep =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      vars =
        config._module.args.vars or {
          latitude = "4.6";
          longitude = "-74.0";
        };
      cfg = config.services.gammastep-custom;
    in
    {
      options.services.gammastep-custom = {
        enable = lib.mkEnableOption "Gammastep service";
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = [ pkgs.gammastep ];

        systemd.user.services.gammastep = {
          description = "Gammastep daemon";

          wantedBy = [ "graphical-session.target" ];
          partOf = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];

          serviceConfig = {
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
        };
      };
    };
}
