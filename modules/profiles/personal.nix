{ ... }:
{
  flake.nixosModules.profilePersonal = {
    preferences.user = {
      name = "rxtsel";
      fullName = "Cristhian Melo";
      email = "rxtsel@outlook.com";
      gitSigningKeyPath = "~/.ssh/github_ed25519.pub";
      sshIdentityFile = "~/.ssh/github_ed25519";
    };
  };
}
