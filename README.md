# My NixOS setup

This repository contains my **NixOS configuration** using **flakes** and **home-manager**, designed with a **scalable, role-based architecture**.

The goal is to keep the system:

* Modular
* Reusable across multiple machines (desktop, laptop, VMs)
* Declarative and easy to extend

---

## Repository Structure

```text
.
├── docs
├── flake.nix                 # Flake entrypoint
│
├── vars                      # Shared variables (identity, roles, hosts)
│   ├── default.nix
│   └── hosts
│       └── blackout.nix
│
├── hosts                     # Host-specific configuration (one folder per machine)
│   └── blackout
│       ├── default.nix
│       └── hardware.nix
│
├── nixos
│   ├── modules               # Reusable NixOS modules (by domain)
│   │   ├── core              # Base system (boot, users, locale, networking, nixpkgs)
│   │   ├── audio             # PipeWire / audio stack
│   │   ├── desktop           # Desktop environment (TWMs, portals, X11, session vars)
│   │   ├── fonts             # Fonts (Nerd Fonts, etc.)
│   │   ├── hardware          # Optional hardware features (bluetooth, etc.)
│   │   ├── packages          # System packages
│   │   └── shells            # Shells (fish, zsh, etc.)
│   │
│   └── profiles              # Role-based system profiles
│       └── desktop           # Desktop profile (imports all desktop-related modules)
│
└── home
    └── rxtsel
        ├── default.nix       # Home-manager entrypoint (assembly only)
        ├── profiles          # Role-based home profiles
        │   └── desktop
        │
        └── modules           # Home-manager modules (by domain)
            ├── terminal      # Terminal tools (ghostty, kitty, etc.)
            ├── browser       # Browsers (Zen, etc.)
            ├── desktop       # Desktop tools (Niri, Waybar, etc.)
            └── dev           # Developer tooling (git, ssh, signing)
```

---

## Architecture Overview

### Hosts

* Each **host folder represents a real machine** (hostname).
* Contains only:

  * `hardware.nix` (auto-generated, disks, luks, fs)
  * minimal assembly logic
* Example:

  * `blackout` (desktop PC)
  * future: `laptop`, `vm-dev`, `vm-ci`, etc.

---

### Roles & Profiles

Machines are categorized by **role**:

* `desktop`
* `laptop`
* `vm`

The role is defined in:

```text
vars/hosts/<hostname>.nix
```

And determines which profile is loaded:

```nix
imports = [
  ./hardware.nix
  ../../nixos/profiles/${vars.role}.nix
];
```

This allows multiple machines of the same type without duplication.

---

### NixOS Modules

System configuration is split by responsibility:

* **core** → users, locale, networking, boot, nixpkgs
* **desktop** → compositor, portals, X11
* **audio** → PipeWire
* **fonts** → system fonts
* **packages** → base system packages
* **shells** → shells (fish)
* **hardware** → optional features (bluetooth)

Modules are reusable across profiles and hosts.

---

### Home Manager

Home configuration mirrors the same structure:

* Profiles (`desktop`)
* Modules grouped by domain:

  * terminal
  * browser
  * dev tooling

This keeps user configuration clean and portable.

---

## SSH

SSH is configured **declaratively** via home-manager:

* Dedicated SSH key for GitHub
* Explicit `~/.ssh/config`

See full documentation in: [docs/ssh.md](./docs/ssh.md).

---

## Why This Structure

- [x]: Scales to multiple machines
- [x]: Clear separation of concerns
- [x]: No duplicated configuration
- [x]: Easy to extend with new roles or hosts
- [x]: Works cleanly with flakes + home-manager

---

## Usage

```bash
sudo nixos-rebuild switch --flake .#blackout
```
