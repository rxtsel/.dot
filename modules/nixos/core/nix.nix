{inputs, ...}: {
  flake.modules.nixos.coreNix = {...}: {
    programs = {
      direnv = {
        enable = true;
        silent = true;
        loadInNixShell = true;
        direnvrcExtra = ''
          : ''${DIRENV_LOG_FORMAT:=}
        '';
        nix-direnv.enable = true;
      };

      nix-ld.enable = true;
    };

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixpkgs.config.allowUnfree = true;
  };

  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };
}
