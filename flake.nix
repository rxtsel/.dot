{
  description = "rxtsel's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      myVars = import ./vars;
    in {
    nixosConfigurations = {
      # For system configurations use hostnames
      blackout-nix = lib.nixosSystem {
      	inherit system; # Use `system = "x86_64-linux"` but with var.
	specialArgs = {
	  inherit myVars;
	};
	# Use system modules
	modules = [
	  ./hosts/blackout-nix
	];
      };
    };
    homeConfigurations = {
      # For user configurations use usernames
      rxtsel = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	# Home modules for rxtsel user
	modules = [
	 ./home/linux
	];
	extraSpecialArgs = {
	  inherit myVars;
	};
      };
    };
  };
}
