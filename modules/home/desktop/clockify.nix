{...}: {
  flake.modules.homeManager.clockify = {pkgs, ...}: {
    home.packages = [pkgs.clockify];
  };
}
