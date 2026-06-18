{inputs, ...}: {
  flake.modules.homeManager.profileGui = {
    imports = with inputs.self.modules.homeManager; [
      ghostty
      vicinae
      thunderbird
      discord
      noctalia
      wezterm
      theme-sync
    ];
  };
}
