{ pkgs, config, ... }:

let
  home = config.home.homeDirectory;
in
{
  # Add background on start session for two monitors
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper (swaybg)";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = ''
        ${pkgs.swaybg}/bin/swaybg \
          -o DP-1 -i ${home}/Pictures/wallpaper_1.png -m fill \
          -o DP-2 -i ${home}/Pictures/wallpaper_0.png -m fill
      '';
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

