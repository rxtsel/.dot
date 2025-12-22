{ pkgs, vars, ... }:

{
  home = {
    inherit (vars) username;
    homeDirectory = "/home/${vars.username}";

    sessionVariables = {
      EDITOR = "nvim";
    };

    # Custom cursor theme
    pointerCursor = {
      gtk.enable = true;
      name = "macOS";
      size = 24;
      package = pkgs.apple-cursor;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.yazi.enable = true;
}
