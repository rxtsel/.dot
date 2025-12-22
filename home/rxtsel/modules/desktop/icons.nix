{ pkgs, ... }:

let
  mkosIcons = pkgs.fetchurl {
    url = "https://github.com/zayronxio/Mkos-Big-Sur/releases/download/0.3/Mkos-Big-Sur.tar.xz";
    sha256 = "sha256-GNh+ouf6jFRyzIqXXL4fIEp06GlRQRV5XIUa74NmVB8=";
  };
in
{
  home.file.".icons/Mkos-Big-Sur".source = pkgs.runCommand "mkos-big-sur-icons" { } ''
    mkdir -p $out
    tar -xJf ${mkosIcons} -C $out --strip-components=1
  '';
}
