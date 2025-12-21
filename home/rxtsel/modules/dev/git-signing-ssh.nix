{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      gpg.format = "ssh";
      commit.gpgSign = true;
      user.signingKey = "~/.ssh/github_ed25519.pub";
    };
  };
}

