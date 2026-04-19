{ ... }:
{
  flake.modules.homeManager.git =
    { pkgs, osConfig, ... }:
    let
      user = osConfig.preferences.user;
    in
    {
      programs.git = {
        enable = true;
        package = pkgs.git;

        settings = {
          user = {
            name = user.fullName;
            email = user.email;
            signingkey = user.gitSigningKeyPath;
          };
        };
      };
    };
}
