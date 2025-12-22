{ pkgs, ... }:

{
  home.packages = [
    pkgs.vicinae
  ];

  systemd.user.services.vicinae = {
    Unit = {
      Description = "Vicinae launcher server";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.vicinae}/bin/vicinae server";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
