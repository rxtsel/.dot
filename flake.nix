{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs =
    { flake-parts, import-tree, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (import-tree ./modules);
}
