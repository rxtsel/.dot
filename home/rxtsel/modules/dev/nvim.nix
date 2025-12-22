{ pkgs, ... }:

{
  # Need for nvim
  home.packages = with pkgs; [
    gcc
    gnumake
    cargo
    rust-analyzer
    rustc
    nodejs_24
  ];
}
