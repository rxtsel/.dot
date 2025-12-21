{ vars, ... }:

{
  imports = [
    ./hardware.nix
    (../../nixos/profiles + "/${vars.role}.nix")
  ];

  system.stateVersion = "25.11";
}

