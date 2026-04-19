{ inputs, ... }:
{
  flake.modules.homeManager.profileGui = {
    imports = with inputs.self.modules.homeManager; [
      wallust
      waybar
      swaync
      vicinae
      gammastep
    ];
  };
}
