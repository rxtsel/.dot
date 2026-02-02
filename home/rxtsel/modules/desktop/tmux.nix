{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"

      # Action key
      unbind C-b
      set-option -g prefix C-t
      set-option -g repeat-time 0
      set-option -g focus-events on

      set-option -g repeat-time 0
      set-option -g focus-events on

      # Disable login shell
      set -g default-command "exec $SHELL"

      # Key bindings
      set-window-option -g mode-keys vi

      # Reload settings
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Open current directory
      bind o run-shell "open '#{pane_current_path}'"
      bind -r e kill-pane -a

      # Moving window
      bind-key -n C-S-Left swap-window -t -1 \; previous-window
      bind-key -n C-S-Right swap-window -t +1 \; next-window

      # Basic settings
      set-option -g status-justify "left"
      set-window-option -g mode-keys vi

      # Look'n feel
      set-option -g status-fg cyan
      set-option -g status-bg black
      set -g pane-active-border-style fg=colour166,bg=default
      set -g window-style fg=colour10,bg=default
      set -g window-active-style fg=colour12,bg=default
      set-option -g history-limit 64096

      set -sg escape-time 10

      # Allow the title bar to adapt to whatever host you connect to
      set -g set-titles on
      set -g set-titles-string "#T"

      # Theme colors
      # default statusbar colors
      set-option -g status-style bg=colour235,fg=colour136,default

      # default window title colors
      set-window-option -g window-status-style fg=colour244,bg=colour234,dim

      # active window title colors
      set-window-option -g window-status-current-style fg=colour166,bg=default,bright

      # pane border
      set-option -g pane-border-style fg=colour235 #base02
      set-option -g pane-active-border-style fg=colour136,bg=colour235

      # message text
      set-option -g message-style bg=colour235,fg=colour166

      # pane number display
      set-option -g display-panes-active-colour colour33 #blue
      set-option -g display-panes-colour colour166 #orange

      # clock
      set-window-option -g clock-mode-colour colour64 #green

      # Status line
      set -g mode-style "fg=#eee8d5,bg=#073642"

      set -g message-style "fg=#eee8d5,bg=#073642"
      set -g message-command-style "fg=#eee8d5,bg=#073642"

      set -g pane-border-style "fg=#073642"
      set -g pane-active-border-style "fg=#eee8d5"

      set -g status "on"
      set -g status-interval 1
      set -g status-justify "left"

      set -g status-style "fg=#586e75,bg=#073642"

      set -g status-bg "#002b36"

      set -g status-left-length "100"
      set -g status-right-length "100"

      set -g status-left-style NONE
      set -g status-right-style NONE

      set -g status-left "#[fg=#073642,bg=#eee8d5,bold] #S #[fg=#eee8d5,bg=#93a1a1,nobold,nounderscore,noitalics]#[fg=#15161E,bg=#93a1a1,bold] #(whoami) #[fg=#93a1a1,bg=#002b36]"
      set -g status-right "#[fg=#586e75,bg=#002b36,nobold,nounderscore,noitalics]#[fg=#93a1a1,bg=#586e75]#[fg=#657b83,bg=#586e75,nobold,nounderscore,noitalics]#[fg=#93a1a1,bg=#657b83]#[fg=#93a1a1,bg=#657b83,nobold,nounderscore,noitalics]#[fg=#15161E,bg=#93a1a1,bold] #h "

      setw -g window-status-activity-style "underscore,fg=#839496,bg=#002b36"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=#839496,bg=#002b36"

      # Current path as default
      setw -g window-status-format '#[fg=#002b36,bg=#002b36]#[default] #I  #{?#{==:#W,#{pane_current_command}},#{b:pane_current_path},#W} #[fg=#002b36,bg=#002b36,nobold,nounderscore,noitalics]'
      setw -g window-status-current-format '#[fg=#002b36,bg=#eee8d5]#[fg=#b58900,bg=#eee8d5] #I #[fg=#eee8d5,bg=#b58900] #{?#{==:#W,#{pane_current_command}},#{b:pane_current_path},#W} #[fg=#b58900,bg=#002b36,nobold]'

      # Keep window name if renamed
      set -g automatic-rename off
      setw -g automatic-rename off

      # Display lazygit
      bind -r g display-popup -d '#{pane_current_path}' -w90% -h90% -E lazygit
    '';
  };
}
