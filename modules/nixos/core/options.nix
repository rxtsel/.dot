{lib, ...}: {
  flake.modules.nixos.coreOptions = {...}: {
    options = {
      preferences.user = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "rxtsel";
        };

        fullName = lib.mkOption {
          type = lib.types.str;
          default = "Cristhian Melo";
        };

        email = lib.mkOption {
          type = lib.types.str;
          default = "rxtsel@outlook.com";
        };

        gitSigningKeyPath = lib.mkOption {
          type = lib.types.str;
          default = "~/.ssh/github_ed25519.pub";
        };

        sshIdentityFile = lib.mkOption {
          type = lib.types.str;
          default = "~/.ssh/github_ed25519";
        };
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
