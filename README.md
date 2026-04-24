# My NixOS setup

NixOS setup based on a Solarized-style theme. This repository tries to follow a dendritic pattern, keeping shared logic in common modules and machine-specific details inside each host folder.

If you download this repo, change `modules/nixos/core/options.nix` or set `preferences.user` in your own host configuration before building.

![Screenshot of Niri](./assets/screenshots/2026-04-23%2019-10-38.png)

## Structure

```text
.
├── assets/
│   └── wallpapers/        # Wallpaper collection
├── docs/                  # Notes and documentation
│   └── adr/               # Architecture decisions
└── modules/
    ├── home/              # Home Manager modules
    ├── hosts/             # Host-specific machine configs
    │   ├── blackout/      # Desktop host
    │   └── matebook-d15/  # Laptop host
    └── nixos/             # Shared NixOS modules
```

To add more hosts, create a new folder inside `modules/hosts/` and place there the machine's own generated hardware and configuration files, based on what NixOS creates for that system during setup.
