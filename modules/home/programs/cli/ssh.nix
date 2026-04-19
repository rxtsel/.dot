{...}: {
  flake.modules.homeManager.ssh = {osConfig, ...}: let
    identityFile = osConfig.preferences.user.sshIdentityFile;
  in {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        "github.com" = {
          host = "github.com";
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
