{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "robbyrussell";
    };

    shellAliases = let flakeDir = "~/.dots"; in {
      # Update system
      nixsw = "sudo nixos-rebuild switch --flake ${flakeDir}";
      # Delete all old versions
      nixprune = "sudo nix-collect-garbage -d";
      # Update home packages
      hmsw = "home-manager switch --flake ${flakeDir}";
      # List home-manager generations.
      # For rollback, first identify your version to rollback,
      # then use: /nix/store/<hash>-home-manager-generation/activate
      hmls = "home-manager generations";

      pro = "cd ~/Projects";
      vim = "nvim";
      zz = "cd ~/.config";
      z = "zellij";
      ls = "eza --icons";
      cat = "bat";
    };
  };
}
