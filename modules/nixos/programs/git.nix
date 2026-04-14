{ self, inputs, ... }:
{

  flake.nixosModules.git =
    { pkgs, config, ... }:
    {
      programs.git = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.git;
        config = {
          user = {
            name = config.preferences.user.fullName;
            email = config.preferences.user.email;
            signingkey = config.preferences.user.gitSigningKeyPath;
          };
        };
      };
    };

  perSystem =
    { pkgs, ... }:
    {

      packages.git = inputs.wrapper-modules.wrappers.git.wrap {
        inherit pkgs;

        settings = {
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

    };

}
