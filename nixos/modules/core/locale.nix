{ vars, ... }:

{
  time.timeZone = vars.timeZone;
  i18n.defaultLocale = vars.defaultLocale;

  # Console keymap
  console = {
    font = "Lat2-Terminus16";
    keyMap = "${vars.keyboard.consoleKeyMap}";
  };
}
