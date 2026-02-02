{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    ghostty
    yazi
    zoxide
    chromium
    swaybg
    eza
    tree
    bat
    wget
    btop
    bluetui
    pavucontrol
    mpv
    macchina
    nautilus
  ];
}
