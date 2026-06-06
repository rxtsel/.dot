{...}: {
  flake.modules.homeManager.tmux = {
    programs.tmux = {
      enable = true;

      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 100000;
      keyMode = "vi";
      mouse = true;
      prefix = "C-a";
      terminal = "tmux-256color";

      aggressiveResize = true;
      customPaneNavigationAndResize = true;
      focusEvents = true;
      newSession = true;
      resizeAmount = 5;

      extraConfig = ''
        # WezTerm / truecolor
        set -g set-clipboard on
        set -as terminal-features ',wezterm:RGB'
        set -ag terminal-overrides ',xterm-256color:RGB'

        # Behaviour
        set -g repeat-time 0
        set -g default-command "''${SHELL}"
        set -g set-titles on
        set -g set-titles-string "#T"

        # Windows / panes
        set -g renumber-windows on
        set -g automatic-rename off
        setw -g automatic-rename off
        set -g allow-rename off

        # Status line
        set -g status on
        set -g status-position bottom
        set -g status-interval 1
        set -g status-justify left
        set -g status-style "fg=#586e75,bg=#002b36"
        set -g status-left-length 100
        set -g status-right-length 100
        set -g status-left-style none
        set -g status-right-style none
        set -g status-left "#[fg=#073642,bg=#eee8d5,bold] #S #[fg=#eee8d5,bg=#93a1a1,nobold,nounderscore,noitalics]#[fg=#15161E,bg=#93a1a1,bold] #(whoami) #[fg=#93a1a1,bg=#002b36]"
        set -g status-right "#[fg=#586e75,bg=#002b36,nobold,nounderscore,noitalics]#[fg=#657b83,bg=#586e75,nobold,nounderscore,noitalics]#[fg=#93a1a1,bg=#657b83,nobold,nounderscore,noitalics]#[fg=#15161E,bg=#93a1a1,bold] #h "

        setw -g window-status-activity-style "underscore,fg=#839496,bg=#002b36"
        setw -g window-status-separator ""
        setw -g window-status-style "none,fg=#839496,bg=#002b36"
        setw -g window-status-format '#[fg=#002b36,bg=#002b36]#[default] #I  #{?#{==:#W,#{pane_current_command}},#{b:pane_current_path},#W} #[fg=#002b36,bg=#002b36,nobold,nounderscore,noitalics]'
        setw -g window-status-current-format '#[fg=#002b36,bg=#eee8d5]#[fg=#b58900,bg=#eee8d5] #I #[fg=#eee8d5,bg=#b58900] #{?#{==:#W,#{pane_current_command}},#{b:pane_current_path},#W} #[fg=#b58900,bg=#002b36,nobold]'

        set -g mode-style "fg=#eee8d5,bg=#073642"
        set -g message-style "fg=#eee8d5,bg=#073642"
        set -g message-command-style "fg=#eee8d5,bg=#073642"
        set -g pane-border-style "fg=#073642"
        set -g pane-active-border-style "fg=#eee8d5"
        set -g display-panes-active-colour colour33
        set -g display-panes-colour colour166
        setw -g clock-mode-colour colour64

        # Reload config
        bind r source-file ~/.config/tmux/tmux.conf \; display-message 'tmux config reloaded'

        # Splits in current directory
        bind | split-window -h -c '#{pane_current_path}'
        bind - split-window -v -c '#{pane_current_path}'
        unbind '"'
        unbind %

        # New windows in current directory
        bind c new-window -c '#{pane_current_path}'

        # Utility
        bind -r e kill-pane -a
        bind -r g display-popup -d '#{pane_current_path}' -w 90% -h 90% -E lazygit
        bind < swap-window -t -1 \; previous-window
        bind > swap-window -t +1 \; next-window

        # Copy mode
        bind Enter copy-mode
        bind -T copy-mode-vi v send -X begin-selection
        bind -T copy-mode-vi C-v send -X rectangle-toggle
        bind -T copy-mode-vi y send -X copy-selection-and-cancel
        bind -T copy-mode-vi Escape send -X cancel

        # Quality of life
        bind a send-prefix
        bind Space last-window
        bind C-a last-window
      '';
    };
  };
}
