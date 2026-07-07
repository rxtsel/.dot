{...}: {
  flake.modules.homeManager.yaak = {pkgs, ...}: {
    home.packages = [pkgs.yaak];
  };
}
