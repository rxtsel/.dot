{ vars, ... }:

{
  hardware.i2c.enable = true;
  users.users.${vars.username}.extraGroups = [ "i2c" ];
}
