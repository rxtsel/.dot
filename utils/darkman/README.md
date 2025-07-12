# Darkman Setup

Darkman is a tool for automatically switching between light and dark modes on
Linux. It works by calculating sunrise and sunset times based on your
geographical location to automatically change system themes.

It also allows manual switching between modes at any time using the
`darkman toggle` command.

## Prerequisites

Before setting up Darkman, ensure you have the following packages installed:

- `darkman` - The main application
- `xdg-desktop-portal` - Desktop integration portal
- GTK themes - For light/dark mode support (e.g., `Adwaita` themes)

## Configuration

### 1. Create Darkman Configuration

Create the configuration file at `~/.config/darkman/config.yaml`:

```yaml
lat: 4.711        # Replace with your latitude
lng: -74.0721     # Replace with your longitude
usegeoclue: false
portal: true
dbusserver: true
```

**Note:** Update the `lat` and `lng` values with your actual coordinates.

### 2. Create Dark Mode Script

Create the dark mode script at `~/.local/share/dark-mode.d/gtk-theme`:

```bash
#!/bin/sh

dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-Dark'"
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/interface/icon-theme "'Mkos-Big-Sur-Night'"
```

Make it executable:

```bash
chmod +x ~/.local/share/dark-mode.d/gtk-theme
```

### 3. Create Light Mode Script

Create the light mode script at `~/.local/share/light-mode.d/gtk-theme`:

```bash
#!/bin/sh

dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
dconf write /org/gnome/desktop/interface/icon-theme "'Mkos-Big-Sur'"
```

Make it executable:

```bash
chmod +x ~/.local/share/light-mode.d/gtk-theme
```

### 4. Configure XDG Desktop Portal

Create the portal configuration directory and file:

```bash
mkdir -p ~/.config/xdg-desktop-portal
```

Edit `~/.config/xdg-desktop-portal/portals.conf` and add:

```ini
[preferred]
org.freedesktop.impl.portal.Settings=darkman
```

### 5. Enable Darkman Service

Enable and start the Darkman systemd service:

```bash
systemctl --user enable --now darkman.service
```

## Usage

- **Automatic switching:** Darkman will automatically switch themes based on
  sunrise/sunset times
- **Manual toggle:** Use `darkman toggle` to switch modes manually
- **Check status:** Use `darkman get` to see the current mode

## Troubleshooting

If Darkman isn't working as expected:

1. Check service status: `systemctl --user status darkman.service`
2. Verify configuration file syntax
3. Ensure scripts have execute permissions
4. Check logs: `journalctl --user -u darkman.service`
