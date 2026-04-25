{inputs, ...}: {
  flake.modules.homeManager.profileCommon = {
    imports = with inputs.self.modules.homeManager; [
      base
      fish
      starship
      ssh
      zoxide
      fzf
      macchina
      yazi
    ];
  };
}
