{
  programs.starship = {
    enable = true;

    settings = {
      localip = {
        ssh_only = false;
        format = "📟 [$localipv4](bold red) ";
        disabled = true;
      };

      username = {
        style_user = "green bold";
        style_root = "red bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "on [$hostname](bold yellow) ";
        trim_at = ".";
        disabled = false;
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";

        # normal / visual / replace / replace_one (fish)
        vimcmd_symbol = "[➜](bold blue)";
        vimcmd_visual_symbol = "[➜](bold yellow)";
        vimcmd_replace_symbol = "[➜](bold purple)";
        vimcmd_replace_one_symbol = "[➜](bold purple)";
      };

      directory = {
        read_only = " 󰌾";
        truncation_length = 10;
        truncate_to_repo = true;
        style = "bold italic blue";
      };

      cmd_duration = {
        min_time = 4;
        show_milliseconds = false;
        disabled = false;
        style = "bold italic red";
      };

      elixir.symbol = " ";
      elm.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = "󰟓 ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      nim.symbol = " ";
      # nix_shell.symbol = " ";
      nix_shell.disabled = true;
      # package.symbol = "󰏗 ";
      package.disabled = true;
      perl.symbol = " ";
      php.symbol = " ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      shlvl.symbol = " ";
      swift.symbol = "ﯣ ";
      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      lua.symbol = " ";
      python.symbol = " ";
      terraform.symbol = "󰘏 ";

      nodejs = {
        format = "via [ Node.js $version](bold green) ";
        detect_files = [
          "package.json"
          ".node-version"
        ];
        detect_folders = [ "node_modules" ];
      };

      docker_context = {
        symbol = " ";
        format = "via [$symbol$context]($style) ";
        style = "blue bold";
        only_with_files = true;
        detect_files = [
          "docker-compose.yml"
          "docker-compose.yaml"
          "Dockerfile"
        ];
        detect_folders = [ ];
        disabled = false;
      };
    };
  };
}
