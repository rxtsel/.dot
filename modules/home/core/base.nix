{ ... }:
{
  flake.modules.homeManager.base = {
    home.stateVersion = "25.11";
    programs.home-manager.enable = true;
  };
}
