{...}: {
  flake.modules.nixos.coreUsers = {
    config,
    lib,
    pkgs,
    ...
  }: let
    shellPackage = shell:
      {
        bash = pkgs.bashInteractive;
        fish = pkgs.fish;
        zsh = pkgs.zsh;
      }
      .${
        shell
      };
  in {
    users.users =
      lib.mapAttrs (_name: user: {
        isNormalUser = true;
        description = user.fullName;
        home = user.home;
        extraGroups = user.extraGroups;
        shell = shellPackage user.shell;
      })
      config.my.users;
  };
}
