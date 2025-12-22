{ vars, ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    xkb = {
      layout = "${vars.keyboard.xkb.layout}";
      variant = "${vars.keyboard.xkb.variant}";
      options = "${vars.keyboard.xkb.options}";
    };

    displayManager.lightdm.enable = false;
  };
}

