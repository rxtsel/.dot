{
  flake.modules.nixos.pearDesktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [pear-desktop];
  };
}
