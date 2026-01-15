{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    ghostty
    yazi
    zoxide
    chromium
    swaybg
    imagemagick
    eza
    tree
    bat
    wget
    btop
    bluetui
    pavucontrol
    mpv
    macchina
    glib
    curl
    jq
    ripgrep
    fd
    unzip
    zip
    gzip
    wl-clipboard
    gcc
    gnumake
    nodejs_24
    nodePackages.pnpm
    nautilus
  ];
}
