{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Only for login shell
      if status is-login
          niri-session
      end

      # Start starship
      starship init fish | source

      # Disable greeting
      set fish_greeting
    '';

    shellAliases = {
      ls = "eza --group-directories-first --icons";
      la = "eza -a --group-directories-first --icons";
      ll = "eza -l --group-directories-first --icons";
      lla = "eza -la --group-directories-first --icons";
      vim = "nvim";
    };

    shellAbbrs = {
      nixrs = "sudo nixos-rebuild switch --flake ~/.dot/#blackout";
      nixgc = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
      nixboot = "sudo bootctl cleanup";
    };

    functions = {
      o = {
        description = "Open current directory (or a given path) with the default file manager via gio";
        body = ''
          if test (count $argv) -eq 0
            gio open .
          else
            gio open $argv[1]
          end
        '';
      };
    };
  };
}
