{...}: {
  flake.modules.nixos.coreUser = {
    config,
    pkgs,
    ...
  }: {
    users.users.${config.preferences.user.name} = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.fish;
    };
  };
}
