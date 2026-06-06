{...}: {
  flake.modules.homeManager.sesh = {
    lib,
    pkgs,
    ...
  }: let
    settingsFormat = pkgs.formats.toml {};
    seshSettings = {
      cache = false;

      session = [
        {
          name = "dotfiles";
          path = "~/.dotfiles";
          startup_command = "nvim";
        }
      ];
    };
    seshSettingsFile = settingsFormat.generate "sesh.toml" seshSettings;
  in {
    programs.sesh = {
      enable = true;
      enableAlias = true;
      enableTmuxIntegration = true;
      icons = true;
      tmuxKey = "s";

      settings = seshSettings;
    };

    home.file.".config/sesh/sesh.toml".enable = lib.mkForce false;

    home.activation.writeSeshSettings = lib.hm.dag.entryAfter ["linkGeneration"] ''
      run mkdir -p "$HOME/.config/sesh"
      if [ ! -e "$HOME/.config/sesh/sesh.toml" ]; then
        run install -m 0644 ${seshSettingsFile} "$HOME/.config/sesh/sesh.toml"
      fi
    '';

    home.packages = [
      pkgs.fd
    ];
  };
}
