{ pkgs, vars, ... }:

{
  services.darkman = {
    enable = true;

    settings = {
      lat = vars.latitude;
      lng = vars.longitude;
      usegeoclue = false;
    };

    darkModeScripts.gtk = ''
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita-Dark"'
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'
    '';

    lightModeScripts.gtk = ''
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita"'
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"default"'
    '';
  };
}
