{...}: {
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      installVimSyntax = true;

      settings = {
        theme = "solarized";
        background-opacity = 0.5;
        font-family = "CaskaydiaCove Nerd Font";
        font-size = 18;

        cursor-invert-fg-bg = true;
        mouse-hide-while-typing = true;
        focus-follows-mouse = true;

        gtk-tabs-location = "bottom";
        gtk-wide-tabs = true;

        window-theme = "ghostty";
        window-decoration = true;
        window-padding-balance = false;
        window-save-state = "never";

        confirm-close-surface = true;
        shell-integration-features = true;
        link-url = true;
        scrollbar = "never";

        keybind = [
          "alt+r=reload_config"
          "alt+t>n=new_tab"
          "alt+p>r=new_split:right"
          "alt+p>d=new_split:down"
          "alt+p>e=equalize_splits"
          "alt+p>z=toggle_split_zoom"
          "alt+p>h=goto_split:left"
          "alt+p>j=goto_split:bottom"
          "alt+p>k=goto_split:top"
          "alt+p>l=goto_split:right"
          "alt+t>l=next_tab"
          "alt+t>h=previous_tab"
          "alt+t>o=toggle_tab_overview"
        ];
      };
    };
  };
}
