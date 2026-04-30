{...}: {
  flake.modules.nixos.coreBasePackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      tree
      opencode
      eza
      bat
      imagemagick
      btop
      jq
    ];
  };
}
