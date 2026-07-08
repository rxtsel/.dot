{...}: {
  flake.modules.nixos.gaming = {pkgs, ...}: {
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      protontricks.enable = true;
    };

    environment.systemPackages = with pkgs; [
      (retroarch.withCores (cores:
        with cores; [
          mesen
          snes9x
          mgba
          mupen64plus
        ]))

      heroic
      dolphin-emu
      mangohud
    ];
  };
}
