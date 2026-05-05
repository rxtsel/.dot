{...}: {
  flake.modules.nixos.coreBasePackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      tree
      eza
      bat
      imagemagick
      btop
      jq
      ripgrep
      pnpm
      nodejs-slim_latest
    ];
  };
}
