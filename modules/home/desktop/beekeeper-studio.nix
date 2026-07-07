{...}: {
  flake.modules.homeManager.beekeeper-studio = {pkgs, ...}: {
    home.packages = [pkgs.beekeeper-studio];
  };
}
