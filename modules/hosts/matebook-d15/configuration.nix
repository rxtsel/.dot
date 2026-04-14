{ self, ... }:
{
  flake.nixosModules.matebookD15Configuration =
    { ... }:
    {
      imports = [
        self.nixosModules.matebookD15Hardware
        self.nixosModules.profileCommon
        self.nixosModules.profilePersonal
        self.nixosModules.profileDesktop
        self.nixosModules.profileLaptop
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot";

      networking.hostName = "matebook-d15";

      my.host = {
        role = "laptop";
        features.ddcci = false;
        wallpaper = ../../../assets/wallpapers/1920x1080/solarized-dark-1.jpg;
        monitors = [
          {
            name = "eDP-1";
            width = 1920;
            height = 1080;
            refresh = 60;
            primary = true;
          }
        ];
      };

      system.stateVersion = "25.11";
    };
}
