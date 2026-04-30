{inputs, ...}: {
  flake.nixosConfigurations.matebook-d15 = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.modules.nixos; [
      matebookD15Hardware
      coreOptions
      coreCommon
      coreUser
      coreBasePackages
      nix
      homeManager
      fonts
      bluetooth
      fcitx5
      neovim
      niri
      cursorTheme
      yaak
      pearDesktop
      brave
      (
        {config, ...}: let
          user = config.preferences.user.name;
        in {
          networking.hostName = "matebook-d15";

          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          boot.loader.efi.efiSysMountPoint = "/boot";

          services.power-profiles-daemon.enable = true;
          services.upower.enable = true;

          # Uncomment and set the user information for overriding the defaults
          # preferences.user = {};

          my.host = {
            role = "laptop";
            features.ddcci = false;
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

          home-manager.users.${user} = {
            imports = with inputs.self.modules.homeManager; [
              profileCommon
              profileDev
              profileGui
            ];

            home.username = user;
            home.homeDirectory = "/home/${user}";
          };

          system.stateVersion = "25.11";
        }
      )
    ];
  };
}
