{ ... }:
{

  flake.nixosModules.fish =
    { pkgs, ... }:
    {

      users.users.rxtsel = {
        shell = pkgs.fish;
      };

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          # Only for login shell
          if status is-login
              niri-session
          end

          # Disable greeting
          set -g fish_greeting
        '';

        shellAliases = {
          ls = "eza --group-directories-first --icons";
          la = "eza -a --group-directories-first --icons";
          ll = "eza -l --group-directories-first --icons";
          lla = "eza -la --group-directories-first --icons";
        };

        shellAbbrs = {
          nixrs = "sudo nixos-rebuild switch --flake ~/.dot/#matebook-d15";
          nixgc = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
          nixboot = "sudo bootctl cleanup";
          nixcleanall = "sudo nix-collect-garbage -d; and nix-collect-garbage -d; and sudo /run/current-system/bin/switch-to-configuration boot";
        };

      };

      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };

    };

}
