{...}: {
  flake.modules.nixos.coreUser = {
    config,
    pkgs,
    ...
  }: {
    users.users.${config.preferences.user.name} = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.fish;
    };
  };
}
