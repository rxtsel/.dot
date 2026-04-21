{inputs, ...}: {
  flake.nixosConfigurations.blackout = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.modules.nixos; [
      blackoutHardware
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
      clockify
      (
        {config, ...}: let
          user = config.preferences.user.name;
        in {
          networking.hostName = "blackout";

          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          boot.kernel.sysctl." vm.swappiness" = 10;

          my.host = {
            role = "desktop";
            features.ddcci = true;
            wallpaper = {
              pack = "solarized";
              mode = "dark";
              name = "green-flowers2-5120x1440.png";
              layoutPreference = "dual-span";
              fallbackPolicy = "repeat-single";
            };
            monitors = [
              {
                name = "DP-2";
                width = 2560;
                height = 1440;
                refresh = 144;
                primary = false;
              }
              {
                name = "DP-1";
                width = 2560;
                height = 1440;
                refresh = 144;
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
