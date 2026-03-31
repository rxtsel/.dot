{
  flake.nixosModules.swaybg =
    { pkgs, ... }:
    let
      wallpaper = ../../wallpapers/1920x1080/solarized-dark-1.jpg;
    in
    {
      environment.systemPackages = [ pkgs.swaybg ];

      systemd.user.services.swaybg = {
        description = "Swaybg Wallpaper Daemon";
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig = {
          ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${wallpaper} -m fill";
          Restart = "on-failure";
        };

        enable = true;
      };
    };
}
