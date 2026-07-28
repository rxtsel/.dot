{inputs, ...}: {
  flake.nixosConfigurations.thinkpad-t14 = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.modules.nixos; [
      thinkpadt14Hardware
      coreOptions
      coreCommon
      network
      audio
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
      yaak
      pearDesktop
      tailscale
      obsidian
      brave
      beekeeper-studio
      gpg
      localsend
      android
      virtualization
      (
        {config, ...}: let
          user = config.preferences.user.name;
        in {
          networking.hostName = "thinkpad-t14";

          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          boot.kernel.sysctl." vm.swappiness" = 10;

          nixpkgs.config.allowUnfree = true;

          my.desktop = {
            terminal = "wezterm";
            autostartApps = [
              "noctalia"
              "discord"
              "thunderbird"
            ];
          };

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
