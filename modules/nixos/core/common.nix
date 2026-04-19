{...}: {
  flake.modules.nixos.coreCommon = {
    networking.networkmanager.enable = true;
    programs.fish.enable = true;

    time.timeZone = "America/Bogota";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "dvorak";
    };

    services.libinput.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
