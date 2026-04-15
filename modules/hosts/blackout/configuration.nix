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
        wallpaper = {
          pack = "solarized";
          mode = "dark";
          name = "palettes-7680x4320.jpg";
          layoutPreference = "auto";
          fallbackPolicy = "repeat-single";
        };
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
