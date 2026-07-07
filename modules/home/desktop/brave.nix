{...}: {
  flake.modules.homeManager.brave = {pkgs, ...}: {
    home.packages = [pkgs.brave];
  };
}
