{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      theme = "Solarized Dark - Patched";
      background-opacity = 0.65;
      background-blur = true;
      font-family = "CaskaydiaCove Nerd Font";
      font-size = 18;
      cursor-style = "block";
      cursor-style-blink = false;
      cursor-invert-fg-bg = true;
      mouse-hide-while-typing = true;
      gtk-tabs-location = "bottom";
      title = " ";

      # MacOS-specific settings
      macos-titlebar-style = "tabs";
      macos-option-as-alt = true;

      # Window controls
      confirm-close-surface = true;
      window-decoration = true;
      window-padding-balance = true;
      window-save-state = "always";

      # Auto update settings
      auto-update = "download";
      auto-update-channel = "stable";

      # Extras
      shell-integration-features = true;
      focus-follows-mouse = true;
      link-url = true;

      keybind = [
        # Custom keybindings
        "alt+r=reload_config"
        "alt+i=inspector:toggle"
        "alt+f=toggle_fullscreen"
        "alt+left=previous_tab"
        "alt+right=next_tab"

        # Zellij-like prefix controlled keybindings
        "alt+t>n=new_tab"
        # Splits
        "alt+p>r=new_split:right"
        "alt+p>d=new_split:down"
        "alt+p>e=equalize_splits"
        "alt+p>z=toggle_split_zoom"
        # Split navigation
        "alt+p>h=goto_split:left"
        "alt+p>j=goto_split:bottom"
        "alt+p>k=goto_split:top"
        "alt+p>l=goto_split:right"
        "alt+p>left=goto_split:left"
        "alt+p>down=goto_split:bottom"
        "alt+p>up=goto_split:top"
        "alt+p>right=goto_split:right"
        "alt+h=goto_split:left"
        "alt+j=goto_split:bottom"
        "alt+k=goto_split:top"
        "alt+l=goto_split:right"
        # Tabs navigation
        "alt+t>l=next_tab"
        "alt+t>h=previous_tab"
      ];
    };
  };
}
