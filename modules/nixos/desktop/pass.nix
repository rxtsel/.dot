{
  flake.modules.nixos.pass = {pkgs, ...}: {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    environment.systemPackages = with pkgs; [
      oath-toolkit
      (pass.withExtensions (exts: [
        exts.pass-otp
      ]))
    ];
  };
}
