{inputs, ...}: {
  flake.nixosConfigurations.blackout = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.modules.nixos; [
      blackoutHardware
      coreOptions
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
      niri
      cursorTheme
      pearDesktop
      tailscale
      gpg
      localsend
      (
        {...}: let
          user = "rxtsel";
        in {
          networking.hostName = "blackout";

          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          boot.kernel.sysctl." vm.swappiness" = 10;

          nixpkgs.config.allowUnfree = true;

          my.users.${user} = {
            fullName = "Cristhian Melo";
            extraGroups = ["wheel"];
          };

          my.desktop = {
            terminal = "wezterm";
            autostartApps = [
              "noctalia"
              "discord"
              "thunderbird"
            ];
          };

          my.host = {
            role = "desktop";
            features.ddcci = true;
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

          home-manager.users.${user} = {
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
              beekeeper-studio
              clockify
              yaak
            ];

            home.username = user;
            home.homeDirectory = "/home/${user}";

            my.identity = {
              fullName = "Cristhian Melo";
              email = "rxtsel@outlook.com";
            };
          };

          system.stateVersion = "25.11";
        }
      )
    ];
  };
}
