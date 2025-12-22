{ pkgs, config, ... }:

# Change background for light/dark mode in Sway using swaybg and darkman.
let
  home = config.home.homeDirectory;

  swaybgStart = pkgs.writeShellScript "swaybg-start" ''
    set -eu

    mode="$(${pkgs.darkman}/bin/darkman get 2>/dev/null || echo light)"

    if [ "$mode" = "dark" ]; then
      wp1="${home}/Pictures/wallpaper_dark_1.png"
      wp2="${home}/Pictures/wallpaper_dark_0.png"
    else
      wp1="${home}/Pictures/wallpaper_light_1.png"
      wp2="${home}/Pictures/wallpaper_light_0.png"
    fi

    exec ${pkgs.swaybg}/bin/swaybg \
      -o DP-1 -i "$wp1" -m fill \
      -o DP-2 -i "$wp2" -m fill
  '';
in
{
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper (swaybg)";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${swaybgStart}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
