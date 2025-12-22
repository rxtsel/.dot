{ pkgs, ... }:

let
  ghosttyTemplate = ''
    background = "{{background}}"
    foreground = "{{foreground}}"
    selection-background = "{{color7}}"
    selection-foreground = "{{background}}"
    cursor-color = "{{cursor}}"

    # Normal colors
    palette = 0={{color0}}
    palette = 1={{color1}}
    palette = 2={{color2}}
    palette = 3={{color3}}
    palette = 4={{color4}}
    palette = 5={{color5}}
    palette = 6={{color6}}
    palette = 7={{color7}}

    # Bright colors
    palette = 8={{color8}}
    palette = 9={{color9}}
    palette = 10={{color10}}
    palette = 11={{color11}}
    palette = 12={{color12}}
    palette = 13={{color13}}
    palette = 14={{color14}}
    palette = 15={{color15}}
  '';

  hyprTemplate = ''
    general {
        col.active_border = rgb({{color4 | strip}})
        col.inactive_border = rgba({{color0 | strip}}00)
    }
  '';

  waybarTemplate = ''
    @define-color cursor {{cursor}};
    @define-color background {{background}};
    @define-color foreground {{foreground}};
    @define-color color0  {{color0 }};
    @define-color color1  {{color1 }};
    @define-color color2  {{color2 }};
    @define-color color3  {{color3 }};
    @define-color color4  {{color4 }};
    @define-color color5  {{color5 }};
    @define-color color6  {{color6 }};
    @define-color color7  {{color7 }};
    @define-color color8  {{color8 }};
    @define-color color9  {{color9 }};
    @define-color color10 {{color10}};
    @define-color color11 {{color11}};
    @define-color color12 {{color12}};
    @define-color color13 {{color13}};
    @define-color color14 {{color14}};
    @define-color color15 {{color15}};
  '';

  swayncTemplate = waybarTemplate;

  solarizedDark = ''
    {
      "colors": {
        "color0": "#073642",
        "color1": "#dc322f",
        "color10": "#859900",
        "color11": "#b58900",
        "color12": "#268bd2",
        "color13": "#d33682",
        "color14": "#2aa198",
        "color15": "#eee8d5",
        "color2": "#859900",
        "color3": "#b58900",
        "color4": "#268bd2",
        "color5": "#d33682",
        "color6": "#2aa198",
        "color7": "#eee8d5",
        "color8": "#6c7c80",
        "color9": "#dc322f"
      },
      "special": {
        "background": "#073642",
        "cursor": "#dc322f",
        "foreground": "#fdf6e3"
      }
    }
  '';

  solarizedLight = ''
    {
      "colors": {
        "color0": "#eee8d5",
        "color1": "#dc322f",
        "color10": "#859900",
        "color11": "#b58900",
        "color12": "#268bd2",
        "color13": "#d33682",
        "color14": "#2aa198",
        "color15": "#073642",
        "color2": "#859900",
        "color3": "#b58900",
        "color4": "#268bd2",
        "color5": "#d33682",
        "color6": "#2aa198",
        "color7": "#073642",
        "color8": "#6c7c80",
        "color9": "#dc322f"
      },
      "special": {
        "background": "#eee8d5",
        "cursor": "#dc322f",
        "foreground": "#002b36"
      }
    }
  '';
in
{
  home.packages = [
    pkgs.wallust

    (pkgs.writeShellScriptBin "theme-solarized-dark" ''
      exec ${pkgs.wallust}/bin/wallust cs solarized-dark
    '')

    (pkgs.writeShellScriptBin "theme-solarized-light" ''
      exec ${pkgs.wallust}/bin/wallust cs solarized-light
    '')
  ];
  xdg = {
    configFile = {

      "wallust/wallust.toml".text = ''
        backend = "fastresize"
        color_space = "lch"
        palette = "dark"

        [templates]
        waybar.template = 'waybar.css'
        waybar.target = '~/.config/waybar/colors.css'

        hypr.template = 'hyprland.conf'
        hypr.target = '~/.config/hypr/themes/wallust.conf'

        swaync.template = 'swaync.css'
        swaync.target = '~/.config/swaync/colors.css'
      '';

      "wallust/templates/ghostty.conf".text = ghosttyTemplate;
      "wallust/templates/hyprland.conf".text = hyprTemplate;
      "wallust/templates/waybar.css".text = waybarTemplate;
      "wallust/templates/swaync.css".text = swayncTemplate;

      "wallust/colorschemes/solarized-dark.json".text = solarizedDark;
      "wallust/colorschemes/solarized-light.json".text = solarizedLight;
    };
  };
}
