{ pkgs, ... }:

{
  # Fnm support
  home.packages = with pkgs; [ fnm ];
  programs.zsh.initContent = ''
    export PATH="$HOME/.fnm:$PATH"
    eval "$(fnm env --use-on-cd)"
  '';
}
