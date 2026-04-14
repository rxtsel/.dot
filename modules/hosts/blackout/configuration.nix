{ self, ... }:
{
  flake.nixosModules.blackoutConfiguration =
    { ... }:
    {
      imports = [
        self.nixosModules.blackoutHardware
        self.nixosModules.profileCommon
        self.nixosModules.profilePersonal
        self.nixosModules.profileDesktop
      ];

      networking.hostName = "blackout";

      my.host = {
        role = "desktop";
        features.ddcci = true;
        wallpaper = ../../../assets/wallpapers/1920x1080/solarized-dark-1.jpg;
        monitors = [
          {
            name = "DP-1";
            width = 2560;
            height = 1440;
            refresh = 144;
            primary = true;
          }
          {
            name = "DP-2";
            width = 2560;
            height = 1440;
            refresh = 144;
            primary = false;
          }
        ];
      };

      system.stateVersion = "25.11";
    };
}
