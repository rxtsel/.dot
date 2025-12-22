{ vars, pkgs, ... }:

{
  home.packages = [ pkgs.gammastep ];

  services.gammastep = {
    enable = true;

    inherit (vars) latitude;
    inherit (vars) longitude;

    temperature = {
      day = 6500;
      night = 3700;
    };

    provider = "manual";
  };
}
