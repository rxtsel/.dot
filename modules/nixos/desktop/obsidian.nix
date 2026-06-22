{...}: {
  flake.modules.nixos.obsidian = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
