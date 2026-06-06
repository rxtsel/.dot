{
  flake.modules.homeManager.fzf = {
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;

      tmux.enableShellIntegration = true;
    };
  };
}
