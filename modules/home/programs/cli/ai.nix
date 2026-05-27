{inputs, ...}: {
  flake.modules.homeManager.ai = {pkgs, ...}: {
    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      pi
    ];
  };
}
