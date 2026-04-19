{ ... }:
{
  flake.modules.nixos.coreUser =
    { config, ... }:
    {
      users.users.${config.preferences.user.name} = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
    };
}
