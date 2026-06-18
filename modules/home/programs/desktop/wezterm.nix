{...}: {
  flake.modules.homeManager.wezterm = {
    lib,
    osConfig,
    ...
  }: {
    programs.wezterm = {
      enable = osConfig.my.desktop.terminal == "wezterm";

      settings = {
        color_scheme = lib.generators.mkLuaInline ''
          (function()
              local appearance = "Dark"

              if wezterm.gui then
                  appearance = wezterm.gui.get_appearance()
              end

              if appearance:find("Dark") then
                  return "Solarized Osaka"
              end

              return "Solarized Osaka Light"
          end)()
        '';

        enable_tab_bar = false;
        font = lib.generators.mkLuaInline ''wezterm.font("CaskaydiaCove Nerd Font")'';
        font_size = 16;

        term = "wezterm";
        enable_scroll_bar = false;
        scrollback_lines = 10000;
        check_for_updates = false;
        automatically_reload_config = true;

        adjust_window_size_when_changing_font_size = false;
        cursor_blink_rate = 0;

        window_decorations = "NONE";
        window_background_opacity = 0.65;
        window_padding = {
          top = 0;
          bottom = 0;
          left = 0;
          right = 0;
        };
      };

      colorSchemes = {
        "Solarized Osaka" = {
          background = "#001419";
          foreground = "#839395";
          cursor_bg = "#839395";
          cursor_border = "#839395";
          cursor_fg = "#001419";
          selection_bg = "#1a6397";
          selection_fg = "#839395";
          ansi = [
            "#001419"
            "#db302d"
            "#849900"
            "#b28500"
            "#268bd3"
            "#d23681"
            "#29a298"
            "#fdf5e2"
          ];
          brights = [
            "#063540"
            "#f55350"
            "#b7f900"
            "#ffbf00"
            "#46acf5"
            "#f254a0"
            "#2aeddd"
            "#ffffff"
          ];
        };

        "Solarized Osaka Light" = {
          background = "#fdf5e2";
          foreground = "#576d74";
          cursor_bg = "#576d74";
          cursor_border = "#576d74";
          cursor_fg = "#fdf5e2";
          selection_bg = "#46acf5";
          selection_fg = "#576d74";
          ansi = [
            "#ffffff"
            "#db302d"
            "#849900"
            "#b28500"
            "#268bd3"
            "#d23681"
            "#29a298"
            "#002c38"
          ];
          brights = [
            "#ede7d3"
            "#b7211f"
            "#586600"
            "#664c00"
            "#1a6397"
            "#af2668"
            "#1a6265"
            "#001419"
          ];
        };
      };
    };
  };
}
