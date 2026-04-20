{lib, ...}: {
  flake.modules.homeManager.vicinae = {
    config,
    osConfig,
    pkgs,
    ...
  }: let
    cfg = config.services.vicinae-custom;
    username = osConfig.preferences.user.name;
  in {
    options.services.vicinae-custom.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Vicinae launcher";
    };

    config = lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        bitwarden-cli
      ];
      programs.vicinae = {
        enable = true;
        useLayerShell = true;

        systemd = {
          enable = true;
          autoStart = true;
        };

        settings = {
          theme = {
            dark.name = "solarized-dark";
            light.name = "solarized-light";
          };

          font = {
            rendering = "native";
            normal = {
              family = "SF Pro Display";
              size = 10.5;
            };
          };

          launcher_window = {
            opacity = 0.55;
            blur = {
              enabled = true;
            };
            dim_around = true;
            client_side_decorations = {
              enabled = true;
              rounding = 16;
              border_width = 1;
            };
            compact_mode = {
              enabled = true;
            };
          };

          providers = {
            "@AntonNiklasson/store.raycast.lorem-ipsum" = {
              enabled = true;
              entrypoints.ai-generate.enabled = false;
            };

            "@destiner/store.raycast.json-format" = {
              enabled = true;
              preferences = {
                autopaste = false;
                indent = "2";
              };
              entrypoints = {
                formatJsonLines.enabled = false;
                formatSelectionAndShow.enabled = false;
                formatToJsonValue.enabled = false;
              };
            };

            "@jomifepe/store.raycast.bitwarden" = {
              preferences = {
                fetchFavicons = true;
                repromptIgnoreDuration = "86400000";
                serverUrl = "";
                shouldCacheVaultItems = true;
                syncOnLaunch = true;
                windowActionOnCopy = "close";
                cliPath = "/etc/profiles/per-user/${username}/bin/bw";
              };
              entrypoints = {
                create-send.enabled = false;
                lock-vault.enabled = true;
                logout-vault.enabled = false;
                receive-send.enabled = false;
                search-sends.enabled = false;
              };
            };

            "@sovereign/store.vicinae.awww-switcher" = {
              preferences = {
                colorGenTool = "wallust";
                gridRows = "4";
                postProduction = "no";
                showImageDetails = true;
                toggleVicinaeSetting = true;
                transitionDuration = "3";
                transitionFPS = "60";
                transitionStep = "90";
                transitionType = "random";
                wallpaperPath = "~/.dotfiles/assets/wallpapers/packs/solarized";
                leftMonitor = "DP-2";
                rightMonitor = "DP-1";
              };
              entrypoints.wprandom.enabled = false;
            };

            browser-extension.enabled = false;

            calculator = {
              enabled = true;
              entrypoints.history.enabled = false;
            };

            clipboard = {
              preferences = {
                encryption = false;
                eraseOnStartup = true;
                ignorePasswords = true;
                monitoring = true;
              };
              entrypoints = {
                clear.enabled = false;
                clear-history.enabled = false;
              };
            };

            core.entrypoints = {
              about.enabled = false;
              documentation.enabled = false;
              keybind-settings.enabled = false;
              manage-fallback.enabled = false;
              oauth-token-store.enabled = false;
              open-config-file.enabled = false;
              open-default-config.enabled = false;
              prune-memory.enabled = false;
              refresh-apps.enabled = false;
              reload-scripts.enabled = false;
              report-bug.enabled = false;
              search-builtin-icons.enabled = false;
              settings.enabled = false;
              sponsor.enabled = false;
            };

            developer.enabled = false;

            files = {
              enabled = false;
              preferences = {
                autoIndexing = false;
                excludedPaths = "";
                paths = "/home/${username}";
                watcherPaths = "";
              };
            };

            font = {
              enabled = false;
              entrypoints.browse.enabled = false;
            };

            manage-shortcuts.enabled = false;

            power.entrypoints = {
              hibernate.enabled = false;
              sleep.enabled = false;
              soft-reboot.enabled = false;
              suspend.enabled = false;
            };

            scripts.enabled = false;
            shortcuts.enabled = false;
            system.enabled = false;
            wm.enabled = false;
          };
        };

        themes = {
          solarized-dark = {
            meta = {
              name = "Solarized Dark";
              description = "Low-contrast theme designed to reduce eye strain";
              variant = "dark";
              inherits = "vicinae-dark";
              icon = "icons/solarized.png";
            };
            colors = {
              core = {
                background = "#002B36";
                foreground = "#839496";
                secondary_background = "#073642";
                border = "#586E75";
                accent = "#268BD2";
                accent_foreground = "#ffffff";
              };
              main_window = {
                border = "#586E75";
                footer.background = "colors.core.secondary_background";
              };
              settings_window = {
                border = "#586E75";
              };
              accents = {
                blue = "#268BD2";
                green = "#859900";
                magenta = "#D33682";
                orange = "#CB4B16";
                purple = "#6C71C4";
                red = "#DC322F";
                yellow = "#B58900";
                cyan = "#2AA198";
              };
              shortcut = {
                border = "colors.core.border";
              };
              text = {
                default = "colors.core.foreground";
                muted = "#93A1A1";
                danger = "#DC322F";
                success = "#859900";
                placeholder = "#586E75";
                selection = {
                  background = "#268BD2";
                  foreground = "#ffffff";
                };
                links = {
                  default = "#268BD2";
                  visited = "#6C71C4";
                };
              };
              input = {
                border = "#586E75";
                border_focus = "#268BD2";
                border_error = "#DC322F";
              };
              button.primary = {
                background = "#073642";
                foreground = "#839496";
                hover.background = "#0A4757";
                focus.outline = "colors.core.accent";
              };
              list.item = {
                hover = {
                  background = "#073642";
                  foreground = "#839496";
                  secondary_foreground = "#93A1A1";
                };
                selection = {
                  background = "#073642";
                  foreground = "#839496";
                  secondary_background = "#586E75";
                  secondary_foreground = "#EEE8D5";
                };
              };
              grid.item = {
                background = "#073642";
                hover.outline = "#839496";
                selection.outline = "#268BD2";
              };
              scrollbars = {
                background = "#586E75";
              };
              loading = {
                bar = "#839496";
                spinner = "#839496";
              };
            };
          };

          solarized-light = {
            meta = {
              name = "Solarized Light";
              description = "Light variant of the popular Solarized theme";
              variant = "light";
              inherits = "vicinae-light";
              icon = "icons/solarized.png";
            };
            colors = {
              core = {
                background = "#FDF6E3";
                foreground = "#657B83";
                secondary_background = "#EEE8D5";
                border = "#839496";
                accent = "#268BD2";
                accent_foreground = "#ffffff";
              };
              main_window = {
                border = "#839496";
                footer.background = "colors.core.secondary_background";
              };
              settings_window = {
                border = "#839496";
              };
              accents = {
                blue = "#268BD2";
                green = "#859900";
                magenta = "#D33682";
                orange = "#CB4B16";
                purple = "#6C71C4";
                red = "#DC322F";
                yellow = "#B58900";
                cyan = "#2AA198";
              };
              shortcut = {
                border = "colors.core.border";
              };
              text = {
                default = "colors.core.foreground";
                muted = "#93A1A1";
                danger = "#DC322F";
                success = "#859900";
                placeholder = "#93A1A1";
                selection = {
                  background = "#268BD2";
                  foreground = "#ffffff";
                };
                links = {
                  default = "#268BD2";
                  visited = "#6C71C4";
                };
              };
              input = {
                border = "#839496";
                border_focus = "#268BD2";
                border_error = "#DC322F";
              };
              button.primary = {
                background = "#EEE8D5";
                foreground = "#657B83";
                hover.background = "#F6F0DC";
                focus.outline = "colors.core.accent";
              };
              list.item = {
                hover = {
                  background = "#F7F2E5";
                  foreground = "#657B83";
                  secondary_foreground = "#586E75";
                };
                selection = {
                  background = "#EEE8D5";
                  foreground = "#657B83";
                  secondary_background = "#F6F0DC";
                  secondary_foreground = "#586E75";
                };
              };
              grid.item = {
                background = "#EEE8D5";
                hover.outline = "#657B83";
                selection.outline = "#268BD2";
              };
              scrollbars = {
                background = "#839496";
              };
              loading = {
                bar = "#657B83";
                spinner = "#657B83";
              };
            };
          };
        };
      };
    };
  };
}
