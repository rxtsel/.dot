{...}: let
  ai = import ./_ai-options.nix;
in {
  flake.modules.homeManager.codex = {pkgs, ...}: {
    programs.codex = {
      enable = true;
      enableMcpIntegration = true;

      package = pkgs.callPackage ./_codex/package.nix {
        runtime = "native";
      };

      settings = {
        tui.theme = "solarized-dark";
      };

      context = ai.context;
      skills = ai.skills;
    };
  };
}
