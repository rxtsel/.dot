{
  # Shared identity
  username = "rxtsel";
  fullName = "Cristhian Melo";
  email = "rxtsel@outlook.com";

  # Locale defaults
  timeZone = "America/Bogota";
  latitude = 4.7110;
  longitude = -74.0721;
  defaultLocale = "en_US.UTF-8";

  # Default platform (Can override)
  system = "x86_64-linux";

  # Keyboard layout
  keyboard = {
    xkb = {
      layout = "us";
      variant = "dvorak-intl";
      options = "lv3:ralt-switch,compose:ralt";
    };

    # TTY console keymap
    consoleKeyMap = "dvorak";
  };
}
