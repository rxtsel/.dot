{...}: {
  flake.modules.nixos.localsend = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      localsend
    ];
  };
}
