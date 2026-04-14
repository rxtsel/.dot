{ lib, ... }:
{
  flake.nixosModules.profileLaptop = {
    my.host.role = lib.mkDefault "laptop";

    my.host.monitors = lib.mkDefault [
      {
        name = "eDP-1";
        width = 1920;
        height = 1080;
        refresh = 60;
        primary = true;
      }
    ];
  };
}
