{...}: let
  ai = import ./_ai-options.nix;
in {
  flake.modules.homeManager.opencode = {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;

      settings = {
        autoupdate = true;
        autoshare = false;
      };

      tui = {
        theme = "solarized";
      };

      context = ai.context;
      skills = ai.skills;
    };
  };
}
