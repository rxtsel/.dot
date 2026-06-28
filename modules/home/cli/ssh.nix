{...}: {
  flake.modules.homeManager.ssh = {config, ...}: let
    identityFile = config.my.identity.sshIdentityFile;
  in {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = identityFile;
          identitiesOnly = true;
          addKeysToAgent = "yes";
        };

        "*" = {
          serverAliveInterval = 60;
          serverAliveCountMax = 3;
        };
      };
    };
  };
}
