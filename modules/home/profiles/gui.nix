{inputs, ...}: {
  flake.modules.homeManager.profileGui = {
    imports = with inputs.self.modules.homeManager; [
      ghostty
      vicinae
      thunderbird
      discord
      noctalia-shell
      wezterm
      tmux
      sesh
      theme-sync
    ];
  };
}
