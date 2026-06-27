{
  flake.modules.nixos.gpg = {pkgs, ...}: {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
