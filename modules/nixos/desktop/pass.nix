{
  flake.modules.nixos.pass = {pkgs, ...}: {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    environment.systemPackages = [
      (pkgs.pass.withExtensions (exts: [
        exts.pass-otp
      ]))
    ];
  };
}
