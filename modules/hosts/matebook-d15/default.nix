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
      swaybg
      cursorTheme
      (
        {config, ...}: let
          user = config.preferences.user.name;
        in {
          preferences.user = {
            name = "rxtsel";
            fullName = "Cristhian Melo";
            email = "rxtsel@outlook.com";
            gitSigningKeyPath = "~/.ssh/github_ed25519.pub";
            sshIdentityFile = "~/.ssh/github_ed25519";
          };

          networking.hostName = "matebook-d15";

          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          boot.loader.efi.efiSysMountPoint = "/boot";

          my.host = {
            role = "laptop";
            features.ddcci = false;
            wallpaper = {
              pack = "solarized";
              mode = "dark";
              name = "pacman-1920x1080.png";
              layoutPreference = "auto";
              fallbackPolicy = "repeat-single";
            };
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

          home-manager.users.${user} = {
            imports = with inputs.self.modules.homeManager; [
              profileCommon
              profileDev
              profileGui
            ];

            services.gammastep-custom.enable = true;

            home.username = user;
            home.homeDirectory = "/home/${user}";
          };
        }
      )
    ];
  };
}
