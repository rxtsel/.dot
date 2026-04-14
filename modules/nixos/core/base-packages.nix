{ ... }:
{
  flake.nixosModules.coreBasePackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        zoxide
        yazi
        brightnessctl
        tree
        opencode
        eza
        bat
      ];
    };
}
