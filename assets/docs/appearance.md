## Appearance

### Wallust

#### Active config

- This repo defines Wallust under `/etc/xdg/wallust/` (`wallust.toml`, `templates/`, `colorschemes/`).
- Manual commands should use `-d /etc/xdg/wallust`.

#### Commands

```bash
wallust -d /etc/xdg/wallust cs solarized-dark
systemctl --user restart waybar.service
swaync-client -R
```

```bash
wallust -d /etc/xdg/wallust cs solarized-light
systemctl --user restart waybar.service
swaync-client -R
```

#### Important note (`-C` vs `-d`)

- `-C /etc/xdg/wallust/wallust.toml` loads the TOML file, but templates may still be resolved from `~/.config/wallust/templates`.
- `-d /etc/xdg/wallust` forces both config and templates from the system path and avoids missing-template warnings.

#### Why Waybar restart is needed

- Waybar uses CSS with `@import` to `~/.config/waybar/colors.css`.
- When Wallust rewrites `colors.css`, Waybar does not always refresh that import live.
- `systemctl --user restart waybar.service` reliably applies the new palette.

#### Current targets

- Ghostty reads colors from `~/.config/ghostty/themes/solarized`.
- Waybar reads colors from `~/.config/waybar/colors.css`.
- Swaync reads colors from `~/.config/swaync/colors.css`.
