{ pkgs, ... }:

{
  # TODO: install nvim from repo
  home.packages = with pkgs; [ gcc unzip fd ripgrep wl-clipboard lazygit ];
}
