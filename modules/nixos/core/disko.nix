{inputs, ...}: {
  flake.modules.nixos.coreDisko = {
    imports = [inputs.disko.nixosModules.disko];
  };
}
