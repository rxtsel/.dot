{inputs, ...}: {
  flake.modules.homeManager.profileDev = {
    imports = with inputs.self.modules.homeManager; [
      git
      lazygit
      podman
      codex
    ];
  };
}
