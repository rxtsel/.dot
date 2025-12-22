{ pkgs, ... }:

{
  home.packages = [ pkgs.gammastep ];

  services.gammastep = {
    enable = true;

    latitude = 4.7110;
    longitude = -74.0721;

    temperature = {
      day = 6500;
      night = 3700;
    };

    provider = "manual";
  };
}
