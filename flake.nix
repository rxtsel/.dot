{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Apple Fonts
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;

      baseVars = import ./vars/default.nix;

      hosts = {
        blackout = import ./vars/hosts/blackout.nix;
      };

      mkHost =
        hostKey: hostVars:
        let
          resolvedHostVars =
            hostVars
            // { hostName = hostVars.hostName or hostKey; };

          vars = baseVars // resolvedHostVars;
          system = vars.system;
        in
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs vars;
          };

          modules = [
            (./hosts + "/${vars.hostName}")

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";

              home-manager.extraSpecialArgs = {
                inherit inputs vars;
              };

              home-manager.users.${vars.username} =
                import (./home + "/${vars.username}");
            }
          ];
        };
    in
    {
      nixosConfigurations = lib.mapAttrs mkHost hosts;
    };
}
