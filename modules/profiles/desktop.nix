{ self, ... }:
{
  flake.nixosModules.profileDesktop = {
    imports = [
      self.nixosModules.niri
      self.nixosModules.waybar
      self.nixosModules.notifications
      self.nixosModules.vicinae
      self.nixosModules.swaybg
      self.nixosModules.cursorTheme
      self.nixosModules.gammastep
    ];

    services.gammastep-custom.enable = true;
  };
}
