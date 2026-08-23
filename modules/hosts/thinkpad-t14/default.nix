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
      acpiDdnt
      (
        {config, ...}: let
          user = config.preferences.user.name;
        in {
          networking.hostName = "thinkpad-t14";

          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          boot.kernel.sysctl." vm.swappiness" = 10;

          # Power utils for laptops
          services.upower.enable = true;
          services.tlp = {
            enable = true;
            settings = {
              START_CHARGE_THRESH_BAT0 = 40;
              STOP_CHARGE_THRESH_BAT0 = 80;
            };
          };
          # Firmware util
          services.fwupd.enable = true;
          # Nvme health
          services.fstrim.enable = true;
          # Mount bus
          services.udisks2.enable = true;
          services.gvfs.enable = true;

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

          swapDevices = [
            {
              device = "/swapfile";
              size = 8 * 1024; # 8 GB
            }
          ];

          system.stateVersion = "25.11";
        }
      )
    ];
  };
}
