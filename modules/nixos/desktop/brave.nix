{...}: {
  flake.modules.nixos.brave = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      brave
    ];
  };
}
