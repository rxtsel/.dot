{
  flake.modules.nixos.network = {
    networking.networkmanager = {
      enable = true;
      dns = "dnsmasq";
    };

    environment.etc."NetworkManager/dnsmasq.d/xavel.conf".text = ''
      address=/xavel.test/127.0.0.1
    '';
  };
}
