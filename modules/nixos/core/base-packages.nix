{ ... }:
{
  flake.nixosModules.coreBasePackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        yazi
        brightnessctl
        tree
        opencode
        eza
        bat
      ];
    };
}
