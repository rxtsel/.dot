{ pkgs, ... }:

{
  services.darkman = {
    enable = true;

    settings = {
      lat = 4.711;
      lng = -74.0721;
      usegeoclue = false;
    };

    # Scripts de modo oscuro/claro
    darkModeScripts = {
      gtk-theme = ''
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
      '';
      # agregar aquí otros scripts para aplicaciones Qt u GNOME, etc.
    };
    lightModeScripts = {
      gtk-theme = ''
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
      '';
    };
  };
}
