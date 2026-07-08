{inputs, ...}: let
  hostName = "matebook-d15";
  rxtsel = "rxtsel";
in {
  flake.nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.modules.nixos; [
      matebookD15Hardware
      matebookD15Disk
      coreOptions
      coreDisko
      coreCommon
      systemNetwork
      systemAudio
      coreUsers
      systemPackages
      coreNix
      coreHomeManager
      systemFonts
      bluetooth
      fcitx5
      neovim
      vpn
      gdm
      gnomeShellMinimal
      niri
      cursorTheme
      pearDesktop
      gpg
      onscreen-keyboard
      localsend
      {
        networking.hostName = hostName;

        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
        boot.loader.efi.efiSysMountPoint = "/boot";

        services.power-profiles-daemon.enable = true;
        services.upower.enable = true;

        hardware.graphics.enable = true;

        my.users = {
          ${rxtsel} = {
            fullName = "Cristhian Melo";
            extraGroups = ["wheel"];
          };
        };

        my.desktop = {
          terminal = "wezterm";
          autostartApps = ["noctalia"];
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

        home-manager.users = {
          ${rxtsel} = {
            imports = with inputs.self.modules.homeManager; [
              base
              fish
              starship
              ssh
              zoxide
              fzf
              macchina
              yazi
              ai
              git
              lazygit
              podman
              ghostty
              vicinae
              thunderbird
              discord
              noctalia
              wezterm
              theme-sync
              brave
              obsidian
              yaak
            ];

            home.username = rxtsel;
            home.homeDirectory = "/home/${rxtsel}";

            my.identity = {
              fullName = "Cristhian Melo";
              email = "rxtsel@outlook.com";
            };
          };
        };

        swapDevices = [
          {
            device = "/swapfile";
            size = 8 * 1024; # 8 GB
          }
        ];

        system.stateVersion = "25.11";
      }
    ];
  };
}
