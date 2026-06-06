# Tmux

This setup is optimized for using tmux inside WezTerm. WezTerm acts as a clean terminal frontend, while tmux manages sessions, windows, panes, navigation, and popups.

## Prefix

The tmux prefix is:

| Key | Description |
| --- | --- |
| `C-a` | Main tmux prefix |
| `C-a a` | Send a literal `C-a` to the application running inside tmux |

## Window and pane management

| Keybinding | Action |
| --- | --- |
| `C-a c` | Create a new window in the current pane directory |
| `C-a \|` | Split the current pane horizontally in the current directory |
| `C-a -` | Split the current pane vertically in the current directory |
| `C-a e` | Kill all panes except the current one |
| `C-a <` | Move the current window one position to the left |
| `C-a >` | Move the current window one position to the right |
| `C-a Space` | Switch to the last used window |
| `C-a C-a` | Switch to the last used window |

## Pane navigation

Pane navigation uses Vim-style keys.

| Keybinding | Action |
| --- | --- |
| `C-a h` | Select the pane on the left |
| `C-a j` | Select the pane below |
| `C-a k` | Select the pane above |
| `C-a l` | Select the pane on the right |

## Pane resizing

Pane resizing also uses Vim-style keys. The resize amount is `5` cells.

| Keybinding | Action |
| --- | --- |
| `C-a H` | Resize the pane left |
| `C-a J` | Resize the pane down |
| `C-a K` | Resize the pane up |
| `C-a L` | Resize the pane right |

## Copy mode

| Keybinding | Mode | Action |
| --- | --- | --- |
| `C-a Enter` | normal | Enter copy mode |
| `v` | copy mode | Start selection |
| `C-v` | copy mode | Toggle rectangular selection |
| `y` | copy mode | Copy selection and exit copy mode |
| `Esc` | copy mode | Cancel copy mode |

## Utilities

| Keybinding | Action |
| --- | --- |
| `C-a r` | Reload `~/.config/tmux/tmux.conf` |
| `C-a g` | Open `lazygit` in a popup using the current pane directory |
| `C-a s` | Open the Sesh session picker with fzf |

## Theme switching

The tmux statusline supports light and dark variants through the tmux global environment variable `TMUX_THEME`.

| Keybinding | Action |
| --- | --- |
| `C-a O` | Toggle between light and dark tmux statusline themes |
| `C-a D` | Force the dark tmux statusline theme |
| `C-a L` | Force the light tmux statusline theme |

## Notes

- `$TERM` inside tmux is set to `tmux-256color`.
- Truecolor is enabled for WezTerm.
- Mouse support is enabled.
- Focus events are enabled.
- Windows and panes start at index `1`.
- The statusline uses a Solarized-inspired theme.
- Automatic window renaming is disabled so renamed windows keep their names.
