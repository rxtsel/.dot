{
  flake.modules.homeManager.theme-sync = {pkgs, ...}: let
    desktopThemeSync = pkgs.writeShellApplication {
      name = "desktop-theme-sync";
      runtimeInputs = [
        pkgs.glib
        pkgs.gsettings-desktop-schemas
        pkgs.systemd
        pkgs.tmux
        pkgs.vicinae
      ];
      text = ''
        export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:''${XDG_DATA_DIRS:-}"

        current_theme() {
          local scheme
          scheme="$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null || true)"

          case "$scheme" in
            *prefer-light* | *light*) printf light ;;
            *) printf dark ;;
          esac
        }

        sync_tmux() {
          local theme theme_file
          theme="$(current_theme)"
          theme_file="$HOME/.config/tmux/themes/solarized_osaka_''${theme}.tmux"

          tmux list-sessions >/dev/null 2>&1 || return 0
          [ -f "$theme_file" ] || return 0

          tmux set-environment -g TMUX_THEME "$theme"
          tmux source-file "$theme_file"
          tmux display-message "tmux theme: $theme" 2>/dev/null || true
        }

        sync_vicinae() {
          local theme theme_name
          theme="$(current_theme)"
          theme_name="solarized-$theme"

          vicinae theme set "$theme_name" >/dev/null 2>&1 || true
        }

        apply_all() {
          sync_tmux
          sync_vicinae
        }

        if [ "''${1:-}" = "--apply" ]; then
          apply_all
          exit 0
        fi

        apply_all

        gsettings monitor org.gnome.desktop.interface color-scheme |
          while read -r _; do
            apply_all
          done
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
        ExecStart = "${desktopThemeSync}/bin/desktop-theme-sync";
        Restart = "on-failure";
      };

      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
