{
  flake.modules.nixos.vpn = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];
  };
}
