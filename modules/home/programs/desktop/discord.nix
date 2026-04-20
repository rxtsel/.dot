{lib, ...}: {
  flake.modules.homeManager.discord = {
    pkgs,
    config,
    ...
  }: {
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

      systemd.user.services.discord = {
        Unit = {
          Description = "Systemd unit for Discord App";
          After = ["graphical-session.target"];
          PartOf = ["graphical-session.target"];
        };

        Service = {
          ExecStart = "${lib.getExe pkgs.discord}";
          Restart = "no";
        };

        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };
    };
  };
}
