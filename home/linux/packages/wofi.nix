{ myVars, ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      allow_images = true;
      allow_markup = true;
      show = "drun";
      prompt = "Search";
      width = 500;
      height = 400;
      hide_scroll = true;
      print_command = true;
      insensitive = true;
      columns = 1;
      no_actions = true;
      location = "top";
      y = 150;
      term = myVars.terminal;
    };

    style = ''
      @define-color text #b7c7c9;
      @define-color background #001419;
      @define-color background-alt #002c38;
      @define-color selected #268bd3;
      @define-color white #FFFFFF;

      * {
        all: unset;
        font-family: 'Noto Sans', monospace;
        font-size: 18px;
      }

      window {
        all: unset;
      }

      #outer-box {
        padding: 20px;
        border-radius: 30px;
        background-color: alpha(@background, .5);
      }

      #inner-box {
        margin: 2px;
      }

      #scroll {
        margin: 0px;
        padding: 20px;
      }

      #input {
        all: unset;
        margin: 20px 26px 0px 26px;
        padding: 14px 20px;
        color: @text;
        border: 2px solid transparent;
        border-radius: 16px;
        background-color: @background-alt;
      }

      #input image {
        color: @text;
        padding-right: 10px;
      }

      #input * {
        border: 2px solid transparent;
      }

      #input:focus {
        border: 2px solid @white;
      }

      #text {
        margin: 5px;
        color: @text;
      }

      #entry {
        margin: 5px;
        padding: 10px;
      }

      #entry arrow {
        color: @selected;
      }

      #entry:selected {
        border-radius: 16px;
        background-color: @background-alt;
      }

      #entry:selected #text {
        color: @white;
      }
    '';
  };
}
