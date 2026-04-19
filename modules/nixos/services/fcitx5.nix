{
  flake.modules.nixos.fcitx5 =
    { pkgs, ... }:

    {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";

        fcitx5 = {
          addons = with pkgs; [
            fcitx5-gtk
            qt6Packages.fcitx5-configtool
          ];

          waylandFrontend = true;
        };
      };
    };
}
