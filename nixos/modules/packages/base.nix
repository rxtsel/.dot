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
    tree-sitter
    nil
    nixfmt-rfc-style
    statix
    deadnix
  ];
}
