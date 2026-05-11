{
  flake.modules.nixos.beekeeper-studio = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [beekeeper-studio];
  };
}
