{inputs, ...}: {
  flake.modules.homeManager.profileGui = {
    imports = with inputs.self.modules.homeManager; [
      ghostty
      vicinae
      thunderbird
      zen-browser
      discord
      noctalia-shell
    ];
  };
}
