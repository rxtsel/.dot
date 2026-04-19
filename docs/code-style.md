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

Set the repository hooks path for this clone:

```bash
git config core.hooksPath .githooks
```

The pre-commit hook is versioned in this repo and runs through the flake dev shell, so it does not depend on ephemeral `/nix/store` hook paths.

If you need to refresh the Python pre-commit environments:

```bash
nix develop -c pre-commit install-hooks
```

After setup, every `git commit` runs the repo hook and applies `treefmt` checks automatically.

## New Machine Bootstrap

After cloning on a new machine:

```bash
git config core.hooksPath .githooks
nix develop -c pre-commit install-hooks
nix run path:.#formatter.x86_64-linux --
```

This ensures hooks are active and formatting is consistent from the start.
