{ pkgs, ... }:

{
  services.darkman = {
    enable = true;

    settings = {
      lat = 1.2033996035846188;
      lng = -77.27524860954428;
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
