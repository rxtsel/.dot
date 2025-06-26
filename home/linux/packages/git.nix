{ myVars, ... }:

{
  programs.git = {
    enable = true;
    userName = myVars.userName;
    userEmail = myVars.userEmail;

    aliases = {
      a = "add";
      s = "status -sb";
      c = "commit -m";
      ca = "commit --ammend";
      r = "remote";
      ra = "remote add";
      rr = "remote rm";
      rv = "remote -v";
      rs = "remote show";
      # log = ''
      #   log --pretty=format
      # '';
    };

    extraConfig = {
      init.defaultBranch = "main";
      fetch.prune = true;
      core.editor = "nvim";
    };
  };
}
