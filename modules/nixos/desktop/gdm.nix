{...}: {
  flake.modules.nixos.gdm = {...}: {
    services.displayManager = {
      defaultSession = "gnome";
      gdm.enable = true;
    };

    services.xserver = {
      enable = true;
      xkb = {
        layout = "us,es";
        variant = "dvorak,";
        options = "grp:alt_shift_toggle";
      };
    };
  };
}
