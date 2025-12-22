{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # theme (bobthefish / prompt vars)
      set -g theme_color_scheme terminal-dark
      set -g fish_prompt_pwd_dir_length 1
      set -g theme_display_user yes
      set -g theme_hide_hostname no
      set -g theme_hostname always
    '';

    shellAliases = {
      ls  = "eza --group-directories-first";
      la  = "eza -a --group-directories-first";
      ll  = "eza -l --group-directories-first";
      lla = "eza -la --group-directories-first";
      vim = "nvim";
    };

    shellAbbrs = {
      nixrs = "sudo nixos-rebuild switch --flake ~/.dot/#blackout";
      nixgc = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
      nixboot = "sudo bootctl cleanup";
    };
  };
}

