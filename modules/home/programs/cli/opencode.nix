{...}: let
  ai = import ./_ai-options.nix;
in {
  flake.modules.homeManager.opencode = {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;

      context = ai.context;
      skills = ai.skills;
    };
  };
}
