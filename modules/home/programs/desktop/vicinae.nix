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
            opacity = 0.6;
            client_side_decorations = {
              enabled = true;
              rounding = 16;
              border_width = 1;
            };
            compact_mode = {
              enabled = true;
            };
            layer_shell = {
              enabled = true;
              keyboard_interactivity = "on_demand";
              layer = "top";
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
                wallpaperPath = "~/.dotfiles/assets/wallpapers";
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
              logout = {
                enabled = true;
                preferences = {
                  confirm = true;
                  customProgram = ''
                    systemctl --user stop niri.service || true
                    loginctl terminate-session "$XDG_SESSION_ID"
                  '';
                };
              };
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
              version = 1;
              name = "Solarized Dark";
              description = "Low-contrast theme designed to reduce eye strain";
              variant = "dark";
              inherits = "vicinae-dark";
            };

            colors = {
              core = {
                background = "#002B36";
                foreground = "#839496";
                secondary_background = "#073642";
                border = "#586E75";
                accent = "#268BD2";
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

              list.item = {
                selection = {
                  background = {
                    name = "colors.core.border";
                    opacity = 0.15;
                    lighter = 5;
                    darker = 15;
                  };
                };

                hover = {
                  background = {
                    name = "colors.core.border";
                    opacity = 0.1;
                    lighter = 10;
                    darker = 10;
                  };
                };
              };
            };
          };

          solarized-light = {
            meta = {
              version = 1;
              name = "Solarized Light";
              description = "Light variant of the popular Solarized theme";
              variant = "light";
              inherits = "vicinae-light";
            };

            colors = {
              core = {
                background = "#FDF6E3";
                foreground = "#657B83";
                secondary_background = "#EEE8D5";
                border = "#839496";
                accent = "#268BD2";
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

              list.item = {
                selection = {
                  background = {
                    name = "colors.core.border";
                    opacity = 0.1;
                    darker = 6;
                  };
                };

                hover = {
                  background = {
                    name = "colors.core.border";
                    opacity = 0.05;
                    darker = 6;
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
