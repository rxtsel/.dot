{
  flake.modules.nixos.gpg = {pkgs, ...}: {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;

      # Keep SSH auth handled by OpenSSH's ssh-agent.  The GCR SSH wrapper can
      # leave git/ssh hanging while proxying to its internal agent.
      enableSSHSupport = false;
    };

    # Use a single, predictable SSH agent socket:
    #   $XDG_RUNTIME_DIR/ssh-agent
    # NixOS exports SSH_AUTH_SOCK for interactive shells when this is enabled.
    programs.ssh.startAgent = true;

    # gnome-keyring may still be useful for secrets, but its GCR SSH wrapper
    # conflicts with the OpenSSH agent and was the source of the git hangs.
    services.gnome.gcr-ssh-agent.enable = false;
  };
}
