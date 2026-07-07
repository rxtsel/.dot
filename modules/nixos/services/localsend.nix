{
  flake.modules.nixos.localsend = {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
