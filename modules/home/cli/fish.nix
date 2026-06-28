{
  flake.modules.homeManager.fish = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        # Enable vim mode
        fish_vi_key_bindings

        # Only for login shell on TTY1
        if status is-login; and test (tty) = /dev/tty1
          exec niri-session
        end

        # Disable greeting
        set -g fish_greeting
      '';

      shellAliases = {
        ls = "eza --group-directories-first --icons";
        la = "eza -a --group-directories-first --icons";
        ll = "eza -l --group-directories-first --icons";
        lla = "eza -la --group-directories-first --icons";
        lz = "lazygit";
        cd = "z";
      };

      shellAbbrs = {
        nixrs = "sudo nixos-rebuild switch --flake ~/dotfiles/#(hostnamectl --static)";
        nixgc = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
        nixboot = "sudo bootctl cleanup";
        nixcleanall = "sudo nix-collect-garbage -d; and nix-collect-garbage -d; and sudo /run/current-system/bin/switch-to-configuration boot";
      };
    };
  };
}
