{ ... }:

{
  programs.ssh = {
    enable = true;

    # Stop Home Manager from injecting its own default SSH config
    enableDefaultConfig = false;

    matchBlocks = {
      # GitHub (explicit identity)
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github_ed25519";
        identitiesOnly = true;
        addKeysToAgent = "yes";
      };

      # Defaults for everything else (equivalent to `Host *`)
      "*" = {
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
      };
    };
  };

  services.ssh-agent.enable = true;
}

