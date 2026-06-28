# My NixOS setup

NixOS setup based on a Solarized-style theme. This repository follows a dendritic pattern: hosts compose reusable system and user modules instead of baking user environments into global defaults.

If you download this repo, declare your local users with `my.users` in a host and compose each user's Home Manager environment from the modules under `modules/home/`.

![Screenshot of Niri](./assets/screenshots/2026-04-23%2019-10-38.png)

## Structure

```text
.
├── assets/
│   └── wallpapers/        # Wallpaper collection
├── docs/                  # Notes and documentation
│   └── adr/               # Architecture decisions
└── modules/
    ├── home/              # Per-user Home Manager modules
    │   ├── cli/           # User CLI tools
    │   ├── core/          # Minimal Home Manager foundation
    │   ├── desktop/       # User desktop apps/config
    │   └── services/      # User services
    ├── hosts/             # Host-specific machine configs
    │   ├── blackout/      # Desktop host
    │   └── matebook-d15/  # Laptop host
    └── nixos/             # Shared NixOS system modules
        ├── core/          # Minimal NixOS foundation
        ├── desktop/       # System desktop stack
        ├── programs/      # System-level programs
        ├── services/      # System services
        └── system/        # Global system capabilities
```

To add more hosts, create a new folder inside `modules/hosts/` and place there the machine's own generated hardware and configuration files, based on what NixOS creates for that system during setup.
