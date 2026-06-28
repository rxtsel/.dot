{lib, ...}: {
  flake.modules.homeManager.discord = {config, ...}: {
    options.services.discord.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Discord App";
    };

    config = lib.mkIf config.services.discord.enable {
      programs.discord = {
        enable = true;

        settings = {
          SKIP_HOST_UPDATE = true;
          DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = false;
        };
      };
    };
  };
}
