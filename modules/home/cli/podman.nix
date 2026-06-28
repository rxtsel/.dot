{
  flake.modules.homeManager.podman = {
    services.podman = {
      enable = true;
    };
  };
}
