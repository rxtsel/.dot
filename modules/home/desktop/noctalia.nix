{inputs, ...}: {
  flake.modules.homeManager.noctalia = {config, ...}: let
    homeDir = config.home.homeDirectory;
    dotfilesDir = "${homeDir}/dotfiles";
    defaultWallpaper = "${dotfilesDir}/assets/wallpapers/light/wallhaven_4973vx.jpg";
  in {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      settings = {
        bar = {
          widgets = {
            start = ["workspaces"];
            center = ["audio_visualizer"];
            end = ["tray" "privacy" "clipboard" "network" "bluetooth" "volume" "battery" "group:g1" "clock" "notifications"];
            font_family = "SF Pro Display";
            margin_edge = 0;
            margin_ends = 0;
            padding = 4;
            radius = 0;
            radius_bottom_left = -12;
            radius_bottom_right = -12;
            shadow = false;
            thickness = 24;

            capsule_group = [
              {
                fill = "surface_variant";
                id = "g1";
                members = ["cpu" "temp" "ram" "sysmon"];
                opacity = 1.0;
                padding = 6.0;
              }
            ];
          };
        };

        brightness = {
          enable_ddcutil = true;
        };

        calendar = {
          enabled = true;
        };

        control_center = {
          shortcuts = [
            {type = "wifi";}
            {type = "bluetooth";}
            {type = "nightlight";}
            {type = "notification";}
            {type = "dark_mode";}
            {type = "wallpaper";}
          ];
        };

        desktop_widgets = {
          enabled = false;
          schema_version = 2;
          widget_order = [];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {};
        };

        location = {
          auto_locate = true;
        };

        lockscreen_widgets = {
          enabled = true;
          schema_version = 2;
          widget_order = [
            "lockscreen-login-box@DP-1"
            "lockscreen-login-box@DP-2"
            "lockscreen-widget-0000000000000002"
            "lockscreen-widget-0000000000000001"
          ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {
            "lockscreen-login-box@DP-1" = {
              box_height = 70.0;
              box_width = 400.0;
              cx = 1280.0;
              cy = 1321.0;
              output = "DP-1";
              rotation = 0.0;
              type = "login_box";
              settings = {
                background_color = "surface_variant";
                background_opacity = 0.88;
                background_radius = 12.0;
                input_opacity = 1.0;
                input_radius = 6.0;
                show_login_button = true;
              };
            };
            "lockscreen-login-box@DP-2" = {
              box_height = 70.0;
              box_width = 400.0;
              cx = 1280.0;
              cy = 1321.0;
              output = "DP-2";
              rotation = 0.0;
              type = "login_box";
              settings = {
                background_color = "surface_variant";
                background_opacity = 0.88;
                background_radius = 12.0;
                input_opacity = 1.0;
                input_radius = 6.0;
                show_login_button = true;
              };
            };
            "lockscreen-widget-0000000000000001" = {
              box_height = 336.0;
              box_width = 672.0;
              cx = 1280.0;
              cy = 168.0;
              output = "DP-1";
              rotation = 0.0;
              type = "clock";
              settings = {
                background = false;
                center_text = true;
                clock_style = "digital";
                font_family = "SF Pro Display";
                shadow = false;
              };
            };
            "lockscreen-widget-0000000000000002" = {
              box_height = 64.0;
              box_width = 272.0;
              cx = 1280.0;
              cy = 304.0;
              output = "DP-1";
              rotation = 0.0;
              type = "audio_visualizer";
              settings = {
                aspect_ratio = 2.5;
                background = false;
                bands = 32;
                show_when_idle = true;
              };
            };
          };
        };

        nightlight = {
          enabled = true;
        };

        plugins = {
          enabled = [];
        };

        shell = {
          avatar_path = "${homeDir}/Pictures/logo.jpeg";
          clipboard_enabled = false;
          font_family = "SF Pro Display";
          polkit_agent = true;
          settings_show_advanced = true;
          panel = {
            clipboard_placement = "attached";
            launcher_categories = false;
            launcher_show_icons = false;
            launcher_sort_by_usage = false;
            open_near_click_clipboard = true;
            transparency_mode = "glass";
          };
          screen_corners = {
            enabled = true;
            size = 12;
          };
          screenshot = {
            directory = "${homeDir}/Pictures/screenshots";
          };
          shadow = {
            alpha = 0.01;
          };
        };

        theme = {
          builtin = "Tokyo-Night";
          community_palette = "Solarized";
          mode = "auto";
          source = "wallpaper";
          wallpaper_scheme = "m3-monochrome";
        };

        wallpaper = {
          directory_dark = "${dotfilesDir}/assets/wallpapers/dark";
          directory_light = "${dotfilesDir}/assets/wallpapers/light";
          transition = ["fade" "zoom"];
          default = {
            path = defaultWallpaper;
          };
          last = {
            path = defaultWallpaper;
          };
          monitors = {
            "DP-1" = {
              path = defaultWallpaper;
            };
            "DP-2" = {
              path = defaultWallpaper;
            };
          };
        };

        hooks = {
          started = "systemctl --user start desktop-theme-sync.service";
          theme_mode_changed = "systemctl --user start desktop-theme-sync.service";
        };

        widget = {
          clock = {
            format = "{:%a %d %b}, {:%H:%M}";
          };
          cpu = {
            display = "text";
          };
          keyboard_layout = {
            glyph = "";
            show_icon = false;
          };
          media = {
            hide_when_no_media = true;
          };
          network = {
            show_label = false;
          };
          privacy = {
            hide_inactive = true;
          };
          ram = {
            display = "text";
          };
          sysmon = {
            display = "text";
            stat = "disk_pct";
          };
          temp = {
            display = "text";
          };
          tray = {
            drawer = true;
          };
          volume = {
            show_label = false;
          };
          workspaces = {
            display = "none";
            hide_when_empty = true;
            pill_scale = 0.55;
          };
        };
      };
    };
  };
}
