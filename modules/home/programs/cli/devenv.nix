{
  flake.modules.homeManager.devenv = {pkgs, ...}: {
    home.packages = [
      pkgs.devenv
    ];
  };
}
