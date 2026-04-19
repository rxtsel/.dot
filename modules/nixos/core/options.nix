{ lib, ... }:
{
  flake.modules.nixos.coreOptions =
    { ... }:
    {
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

        my.host = {
          role = lib.mkOption {
            type = lib.types.enum [
              "desktop"
              "laptop"
            ];
            default = "laptop";
          };

          wallpaper = {
            pack = lib.mkOption {
              type = lib.types.str;
              default = "solarized";
            };

            mode = lib.mkOption {
              type = lib.types.enum [
                "dark"
                "light"
              ];
              default = "dark";
            };

            name = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
            };

            layoutPreference = lib.mkOption {
              type = lib.types.enum [
                "auto"
                "single"
                "dual-span"
              ];
              default = "auto";
            };

            fallbackPolicy = lib.mkOption {
              type = lib.types.enum [
                "repeat-single"
              ];
              default = "repeat-single";
            };
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

                  wallpaper = lib.mkOption {
                    type = lib.types.nullOr lib.types.path;
                    default = null;
                  };
                };
              }
            );
            default = [ ];
          };
        };
      };
    };
}
