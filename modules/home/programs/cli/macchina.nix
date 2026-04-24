{
  flake.modules.homeManager.macchina = {
    programs.macchina = {
      enable = true;
      settings.show = [
        "Distribution"
        "WindowManager"
        "Shell"
        "DiskSpace"
        "Resolution"
        "Processor"
        "Memory"
      ];
    };
  };
}
