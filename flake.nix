{
  description = "rxtsel's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          # Si prefieres permitir _solo_ apple_cursor, en vez de todo:
          # allowUnfreePredicate = pkg: lib.elem (lib.getName pkg) [ "apple_cursor" ];
        };
      };
      myVars = import ./vars;
    in {
      nixosConfigurations = {
        # For system configurations use hostnames
        blackout-nix = lib.nixosSystem {
          inherit system; # Use `system = "x86_64-linux"` but with var.
          specialArgs = { inherit myVars inputs; };
          # Use system modules
          modules = [ ./hosts/blackout-nix ];
        };
      };
      homeConfigurations = {
        # For user configurations use usernames
        rxtsel = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # Home modules for rxtsel user
          modules = [ ./home/linux ];
          extraSpecialArgs = { inherit myVars; };
        };
      };
    };
}
