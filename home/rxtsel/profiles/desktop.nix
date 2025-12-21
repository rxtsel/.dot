{ pkgs, vars, ... }:

{
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Only for login shell
      if status is-login
          niri-session
      end

      set fish_greeting # Disable greeting
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.yazi.enable = true;

  # Custom cursor theme
  home.pointerCursor = {
    gtk.enable = true;
    name = "macOS";
    size = 24;
    package = pkgs.apple-cursor;
  };
}

