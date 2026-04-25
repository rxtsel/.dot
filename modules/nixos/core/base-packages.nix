{...}: {
  flake.modules.nixos.coreBasePackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      tree
      opencode
      codex
      eza
      bat
      imagemagick
      btop
      jq
    ];
  };
}
