{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    ghostty
    yazi
    zoxide
    neovim
    chromium
    swaybg
    imagemagick
    eza
    tree
    bat
    wget
    unzip
    btop
    bluetui
    pavucontrol
    mpv
    macchina
  ];
}

