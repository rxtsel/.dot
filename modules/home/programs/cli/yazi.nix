{
  flake.modules.homeManager.yazi = {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;

      settings = {
        mgr = {
          ratio = [2 4 3];
          show_hidden = true;
          sort_by = "mtime";
          sort_dir_first = true;
          sort_reverse = true;
        };
      };

      shellWrapperName = "y";
    };
  };
}
