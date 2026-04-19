{ ... }:
{
  flake.modules.homeManager.swaync =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        swaynotificationcenter
        libnotify
        (writeShellScriptBin "swaync-reload" ''
          ${swaynotificationcenter}/bin/swaync-client -R || true
        '')
      ];

      xdg.configFile."swaync/style.css".text = ''
        @import url("colors.css");

        * {
          font-family: "SF Pro Display", "CaskaydiaCove Nerd Font Propo";
          font-size: 16px;
        }
      '';

      xdg.configFile."swaync/config.json".text = builtins.toJSON {
        "$schema" = "/etc/xdg/swaync/configSchema.json";
        positionX = "right";
        positionY = "top";
        cssPriority = "user";
        control-center-width = 400;
        control-center-height = 860;
        notification-window-width = 480;
        timeout = 10;
        timeout-low = 2;
        timeout-critical = 6;
      };

      systemd.user.services.swaync = {
        Unit = {
          Description = "Sway Notification Center";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };

        Service = {
          ExecStartPre = pkgs.writeShellScript "swaync-prepare-colors" ''
            set -eu

            if [ ! -f "$HOME/.config/swaync/colors.css" ]; then
              install -d "$HOME/.config/swaync"
              cat > "$HOME/.config/swaync/colors.css" <<'EOF'
@define-color cursor #dc322f;
@define-color background #073642;
@define-color foreground #fdf6e3;
@define-color color0  #073642;
@define-color color1  #dc322f;
@define-color color2  #859900;
@define-color color3  #b58900;
@define-color color4  #268bd2;
@define-color color5  #d33682;
@define-color color6  #2aa198;
@define-color color7  #eee8d5;
@define-color color8  #6c7c80;
@define-color color9  #dc322f;
@define-color color10 #859900;
@define-color color11 #b58900;
@define-color color12 #268bd2;
@define-color color13 #d33682;
@define-color color14 #2aa198;
@define-color color15 #eee8d5;
EOF
            fi
          '';
          ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
          Restart = "on-failure";
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
