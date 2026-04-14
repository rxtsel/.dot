{
  flake.nixosModules.swaybg =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      defaultWallpaper = ../../../assets/wallpapers/1920x1080/solarized-dark-1.jpg;
      fallbackWallpaper = config.my.host.wallpaper or defaultWallpaper;

      monitorFlags =
        lib.concatMapStringsSep " "
          (m:
            let
              monitorWallpaper = m.wallpaper or null;
              wallpaperPath = if monitorWallpaper != null then monitorWallpaper else fallbackWallpaper;
            in
            "-o ${m.name} -i ${toString wallpaperPath}")
          config.my.host.monitors;

      swaybgArgs = if config.my.host.monitors == [ ] then "-i ${toString fallbackWallpaper}" else monitorFlags;
    in
    {
      environment.systemPackages = [ pkgs.swaybg ];

      systemd.user.services.swaybg = {
        description = "Swaybg Wallpaper Daemon";
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig = {
          ExecStart = "${pkgs.swaybg}/bin/swaybg ${swaybgArgs} -m fill";
          Restart = "on-failure";
        };

        enable = true;
      };
    };
}
