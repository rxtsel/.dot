{
  flake.modules.nixos.systemNetwork = {
    networking.networkmanager = {
      enable = true;
      dns = "dnsmasq";
    };
  };
}
