{
  flake.modules.nixos.clockify = {pkgs, ...}: {
    environment.systemPackages = [pkgs.clockify];
  };
}
