{ vars, ... }:

{
  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}

