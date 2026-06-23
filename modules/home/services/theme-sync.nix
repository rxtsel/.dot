{
  flake.modules.homeManager.theme-sync = {pkgs, ...}: let
    desktopThemeSync = pkgs.writeShellApplication {
      name = "desktop-theme-sync";
      runtimeInputs = [
        pkgs.glib
        pkgs.gsettings-desktop-schemas
        pkgs.vicinae
      ];
      text = ''
        export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:''${XDG_DATA_DIRS:-}"

        current_theme() {
          local mode
          mode="$(noctalia msg theme-mode-get 2>/dev/null || true)"
          if [ -n "$mode" ]; then
            printf '%s' "$mode"
            return
          fi
          local scheme
          scheme="$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null || true)"
          case "$scheme" in
            *prefer-light* | *light*) printf light ;;
            *) printf dark ;;
          esac
        }

        theme="$(current_theme)"
        theme_name="solarized-$theme"

        vicinae theme set "$theme_name" >/dev/null 2>&1 || true

        # Update gsettings
        if [ "$theme" = "dark" ]; then
          gsettings set org.gnome.desktop.interface color-scheme prefer-dark 2>/dev/null || true
        else
          gsettings set org.gnome.desktop.interface color-scheme prefer-light 2>/dev/null || true
        fi

        state_dir="$HOME/.cache/pi-system-theme"
        state_file="$state_dir/theme"
        mkdir -p "$state_dir"
        if [ ! -f "$state_file" ] || [ "$(cat "$state_file")" != "$theme_name" ]; then
          printf '%s\n' "$theme_name" > "$state_file"
        fi

        # Wallpaper based on theme mode
        wp_dir="$HOME/dotfiles/assets/wallpapers/$theme"
        if [ -d "$wp_dir" ]; then
          wp=$(find "$wp_dir" -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' \) 2>/dev/null | shuf -n 1)
          if [ -n "$wp" ]; then
            noctalia msg wallpaper-set "$wp" 2>/dev/null || true
          fi
        fi
      '';
    };
  in {
    home.packages = [desktopThemeSync];

    systemd.user.services.desktop-theme-sync = {
      Unit = {
        Description = "Synchronize desktop applications with the color scheme";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${desktopThemeSync}/bin/desktop-theme-sync";
      };

      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
