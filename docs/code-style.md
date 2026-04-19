# Code Style and Formatting

This repository uses a single formatting workflow for Nix code:

- `treefmt` as the orchestrator
- `alejandra` as the Nix formatter
- `pre-commit` to autoformat before commits

## Formatting Rules

- All `*.nix` files are formatted by `alejandra` through `treefmt`.
- Keep naming consistent with the architecture:
  - file and directory names in `kebab-case`
  - feature/profile names by capability (`profileCommon`, `profileDev`, `profileGui`)

## Commands

Format all files in the repository:

```bash
nix run path:.#formatter.x86_64-linux --
```

Check formatting without modifying files:

```bash
nix run path:.#formatter.x86_64-linux -- --fail-on-change
```

Run pre-commit hooks on all files:

```bash
nix develop -c pre-commit run --all-files
```

## Pre-commit Setup

Install hooks for this clone:

```bash
nix develop -c pre-commit install --install-hooks
```

After installation, every `git commit` runs `treefmt` automatically.

## New Machine Bootstrap

After cloning on a new machine:

```bash
nix develop -c pre-commit install --install-hooks
nix run path:.#formatter.x86_64-linux --
```

This ensures hooks are active and formatting is consistent from the start.
