{...}: {
  flake.modules.nixos.ghostty = {...}: {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;

      settings = {
        theme = "solarized";
        background-opacity = 0.65;
        background-blur = true;
        font-family = "CaskaydiaCove Nerd Font";
        font-size = 18;

        cursor-style = "block";
        cursor-style-blink = false;
        cursor-invert-fg-bg = true;

        mouse-hide-while-typing = true;
        gtk-tabs-location = "bottom";
        title = "\" \"";

        # Window
        confirm-close-surface = true;
        window-theme = "system";
        window-decoration = true;
        window-padding-balance = false;
        window-save-state = "never";

        # Updates
        auto-update = "download";
        auto-update-channel = "stable";

        # Extras
        shell-integration-features = true;
        focus-follows-mouse = true;
        link-url = true;

        # Keybinds
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
        ];
      };
    };
  };
}
