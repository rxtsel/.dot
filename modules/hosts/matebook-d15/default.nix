{ self, inputs, ... }:
{
  flake.nixosConfigurations.matebook-d15 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.matebookD15Configuration
    ];
  };
}
