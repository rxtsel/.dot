{inputs, ...}: {
  flake.modules.homeManager.base = {
    imports = [
      inputs.self.modules.homeManager.identity
    ];

    home.stateVersion = "25.11";
    programs.home-manager.enable = true;
  };
}
