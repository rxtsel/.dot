{
  flake.nixosModules.cursorTheme =
    { pkgs, lib, ... }:

    {
      environment.systemPackages = [ pkgs.apple-cursor ];

      environment.sessionVariables = {
        XCURSOR_THEME = "macOS";
        XCURSOR_SIZE = "24";
        XDG_DATA_DIRS = [ "${pkgs.apple-cursor}/share" ];
      };

      environment.variables.XCURSOR_PATH = lib.mkForce (
        lib.concatStringsSep ":" [
          "$HOME/.icons"
          "$HOME/.local/share/icons"
          "/run/current-system/sw/share/icons"
          "/run/current-system/sw/share/pixmaps"
        ]
      );

      system.userActivationScripts.cursorTheme.text = ''
        mkdir -p $HOME/.icons/default
        mkdir -p $HOME/.config/gtk-3.0
        mkdir -p $HOME/.config/gtk-4.0

        echo "[Icon Theme]
        Name=macOS
        Inherits=macOS
        Size=24" > $HOME/.icons/default/index.theme

        cat <<EOF > $HOME/.config/gtk-3.0/settings.ini
        [Settings]
        gtk-cursor-theme-name=macOS
        gtk-cursor-theme-size=24
        EOF

        cat <<EOF > $HOME/.config/gtk-4.0/settings.ini
        [Settings]
        gtk-cursor-theme-name=macOS
        gtk-cursor-theme-size=24
        EOF
      '';
    };
}
