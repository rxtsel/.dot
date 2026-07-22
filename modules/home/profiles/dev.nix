{inputs, ...}: {
  flake.modules.homeManager.profileDev = {
    imports = with inputs.self.modules.homeManager; [
      ai
      git
      lazygit
      podman
      devenv
    ];
  };
}
