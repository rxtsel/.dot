{
  flake.modules.nixos.onscreen-keyboard = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wvkbd
    ];
  };
}
