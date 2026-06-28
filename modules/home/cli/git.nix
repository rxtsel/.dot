{...}: {
  flake.modules.homeManager.git = {
    config,
    pkgs,
    ...
  }: let
    identity = config.my.identity;
  in {
    programs.git = {
      enable = true;
      package = pkgs.git;

      settings = {
        user = {
          name = identity.fullName;
          email = identity.email;
          signingkey = identity.gitSigningKeyPath;
        };

        init.defaultBranch = "main";
        pull.rebase = false;
        push.autoSetupRemote = true;

        alias = {
          a = "add";
          s = "status -sb";
          c = "commit -m";
          l = "log --pretty=format:\"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)\" --graph --date=relative --decorate --all";
        };

        gpg.format = "ssh";
        commit.gpgSign = true;
      };
    };

    programs.gh = {
      enable = true;
    };
  };
}
