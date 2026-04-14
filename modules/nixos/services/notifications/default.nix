{ self, ... }:
{
  flake.nixosModules.notifications = {
    imports = [
      self.nixosModules.notificationsService
      self.nixosModules.notificationsSwaync
    ];
  };
}
