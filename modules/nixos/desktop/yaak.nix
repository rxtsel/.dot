{
  flake.modules.nixos.yaak = {pkgs, ...}: {
    environment.systemPackages = [pkgs.yaak];
  };
}
