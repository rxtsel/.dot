{inputs, ...}: {
  flake.modules.homeManager.profileGui = {
    imports = with inputs.self.modules.homeManager; [
      ghostty
      wallust
      waybar
      swaync
      vicinae
      gammastep
    ];
  };
}
