{...}: {
  flake.modules.nixos.gnomeShellMinimal = {pkgs, ...}: {
    systemd.packages = [
      pkgs.gnome-session
      pkgs.gnome-shell
      pkgs.gnome-settings-daemon
    ];

    services.udev.packages = [
      pkgs.mutter
    ];

    services.displayManager.sessionPackages = [
      pkgs.gnome-session.sessions
    ];

    services.dbus.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    programs.dconf.enable = true;
    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

    environment.systemPackages = with pkgs; [
      gnome-shell
      mutter
      gnome-session
      gnome-settings-daemon
      gnome-control-center
      nautilus
      adwaita-icon-theme
    ];
  };
}
