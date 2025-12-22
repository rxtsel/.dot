{ vars, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.${vars.username}.extraGroups = [ "docker" ];
}
