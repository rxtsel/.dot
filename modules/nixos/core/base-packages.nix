{...}: {
  flake.modules.nixos.coreBasePackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      yazi
      tree
      opencode
      codex
      eza
      bat
      imagemagick
      btop
    ];
  };
}
