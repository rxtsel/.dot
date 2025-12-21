{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "dvorak-intl";
      options = "lv3:ralt-switch";
    };

    displayManager.lightdm.enable = false;
  };
}

