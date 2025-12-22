{ pkgs, ... }:

{
  home.packages = [
    pkgs.nodejs_24
    pkgs.nodePackages.pnpm

    (pkgs.writeShellScriptBin "ni" ''
      exec pnpm dlx --package @antfu/ni ni "$@"
    '')
    (pkgs.writeShellScriptBin "nr" ''
      exec pnpm dlx --package @antfu/ni nr "$@"
    '')
    (pkgs.writeShellScriptBin "nlx" ''
      exec pnpm dlx --package @antfu/ni nlx "$@"
    '')
    (pkgs.writeShellScriptBin "nup" ''
      exec pnpm dlx --package @antfu/ni nup "$@"
    '')
    (pkgs.writeShellScriptBin "nun" ''
      exec pnpm dlx --package @antfu/ni nun "$@"
    '')
    (pkgs.writeShellScriptBin "na" ''
      exec pnpm dlx --package @antfu/ni na "$@"
    '')
  ];
}
