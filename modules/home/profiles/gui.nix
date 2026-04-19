{inputs, ...}: {
  flake.modules.homeManager.profileGui = {
    imports = with inputs.self.modules.homeManager; [
      awww
      ghostty
      wallust
      waybar
      swaync
      vicinae
      gammastep
    ];
  };
}
