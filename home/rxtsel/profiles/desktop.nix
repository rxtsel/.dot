{ pkgs, vars, ... }:

{
  home = {
    inherit (vars) username;
    homeDirectory = "/home/${vars.username}";

    sessionVariables = {
      EDITOR = "nvim";

      XCURSOR_THEME = "macOS";
      XCURSOR_SIZE = "24";

      HYPRCURSOR_THEME = "macOS";
      HYPRCURSOR_SIZE = "24";
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
