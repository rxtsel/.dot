{ pkgs, vars, ... }:

{
  services.darkman = {
    enable = true;

    settings = {
      lat = vars.latitude;
      lng = vars.longitude;
      usegeoclue = false;
    };

    darkModeScripts = {
      gtk = ''
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita-Dark"'
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'
      '';
      vicinae = ''
        ${pkgs.vicinae}/bin/vicinae ping >/dev/null 2>&1 || ${pkgs.vicinae}/bin/vicinae server >/dev/null 2>&1 &
        sleep 0.2
        ${pkgs.vicinae}/bin/vicinae theme set "solarized-dark" || true
      '';
      wallpaper = ''
        ${pkgs.systemd}/bin/systemctl --user restart swaybg.service || true
      '';
      wallust = ''
        wallust cs solarized-dark
        systemctl --user restart waybar
        swaync-client -R || true
      '';
    };

    lightModeScripts = {
      gtk = ''
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita"'
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"default"'
      '';
      vicinae = ''
        ${pkgs.vicinae}/bin/vicinae ping >/dev/null 2>&1 || ${pkgs.vicinae}/bin/vicinae server >/dev/null 2>&1 &
        sleep 0.2
        ${pkgs.vicinae}/bin/vicinae theme set "solarized-light" || true
      '';
      wallpaper = ''
        ${pkgs.systemd}/bin/systemctl --user restart swaybg.service
      '';
      wallust = ''
        wallust cs solarized-light
        systemctl --user restart waybar
        swaync-client -R || true
      '';
    };
  };
}
