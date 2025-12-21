{ vars, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = vars.fullName;
        email = vars.email;
      };

      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;

      alias = {
        a = "add";
        s = "status -sb";
        c = "commit -m";
      };
    };
  };
}

