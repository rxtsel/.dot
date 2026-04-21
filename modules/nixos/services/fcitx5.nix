{
  flake.modules.nixos.fcitx5 = {...}: {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        waylandFrontend = true;
      };
    };
  };
}
