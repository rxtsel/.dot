{
  flake.nixosModules.zoxide = {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
