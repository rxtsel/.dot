{lib, ...}: {
  flake.modules.homeManager.identity = {...}: {
    options.my.identity = {
      fullName = lib.mkOption {
        type = lib.types.str;
        description = "Human-readable full name for this Home Manager user.";
      };

      email = lib.mkOption {
        type = lib.types.str;
        description = "Primary email address for this Home Manager user.";
      };

      gitSigningKeyPath = lib.mkOption {
        type = lib.types.str;
        default = "~/.ssh/github_ed25519.pub";
        description = "SSH public key used by Git for commit signing.";
      };

      sshIdentityFile = lib.mkOption {
        type = lib.types.str;
        default = "~/.ssh/github_ed25519";
        description = "Default SSH identity file for this Home Manager user.";
      };
    };
  };
}
