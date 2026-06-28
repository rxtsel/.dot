{lib, ...}: {
  flake.modules.nixos.coreOptions = {...}: {
    options = {
      my.users = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.submodule ({name, ...}: {
            options = {
              fullName = lib.mkOption {
                type = lib.types.str;
                default = name;
                description = "Human-readable full name for this local user.";
              };

              home = lib.mkOption {
                type = lib.types.str;
                default = "/home/${name}";
                description = "Home directory for this local user.";
              };

              extraGroups = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [];
                description = "Additional system groups for this local user.";
              };

              shell = lib.mkOption {
                type = lib.types.enum [
                  "bash"
                  "fish"
                  "zsh"
                ];
                default = "fish";
                description = "Login shell for this local user.";
              };
            };
          })
        );
        default = {};
        description = "Local users declared by hosts. User environments are composed independently with Home Manager.";
      };

      my.desktop = {
        terminal = lib.mkOption {
          type = lib.types.enum [
            "ghostty"
            "wezterm"
          ];
          default = "wezterm";
          description = "Preferred terminal emulator used by desktop modules.";
        };

        autostartApps = lib.mkOption {
          type = lib.types.listOf (lib.types.enum [
            "noctalia"
            "discord"
            "thunderbird"
          ]);
          default = [];
          description = "Desktop applications to spawn when the graphical session starts.";
        };
      };

      my.host = {
        role = lib.mkOption {
          type = lib.types.enum [
            "desktop"
            "laptop"
          ];
          default = "laptop";
        };

        features.ddcci = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };

        monitors = lib.mkOption {
          type = lib.types.listOf (
            lib.types.submodule {
              options = {
                name = lib.mkOption {
                  type = lib.types.str;
                };

                width = lib.mkOption {
                  type = lib.types.int;
                };

                height = lib.mkOption {
                  type = lib.types.int;
                };

                refresh = lib.mkOption {
                  type = lib.types.int;
                  default = 60;
                };

                primary = lib.mkOption {
                  type = lib.types.bool;
                  default = false;
                };
              };
            }
          );
          default = [];
        };
      };
    };
  };
}
