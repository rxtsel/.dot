# Update Codex CLI

This runbook explains how to update the vendored Codex CLI Nix package.

## Scope

The Codex CLI package is vendored locally at:

```text
modules/home/programs/cli/_codex/package.nix
```

The update helper is:

```text
scripts/update-codex.sh
```

The package lives under `_codex` so `import-tree ./modules` ignores it as a module entrypoint.

## Prerequisites

Make sure these commands are available:

```bash
gh
nix-prefetch-url
nix
```

Authenticate GitHub CLI if needed:

```bash
gh auth status
```

## Check for Updates

Run:

```bash
scripts/update-codex.sh --check
```

Exit code meaning:

- `0`: the vendored package is current.
- `1`: a newer Codex release is available.

## Update to the Latest Version

Run:

```bash
scripts/update-codex.sh
```

The script:

- reads the current version from the vendored `package.nix`
- reads the latest `openai/codex` release tag with `gh release view`
- strips the `rust-v` tag prefix
- updates the vendored version
- recalculates native binary hashes
- recalculates the npm package hash
- recalculates node optional dependency hashes
- skips build verification when no straightforward local flake package target exists

## Update to a Specific Version

Run:

```bash
scripts/update-codex.sh --version 0.125.0
```

Use the upstream Codex version number without the `rust-v` prefix.

## Validate

First validate the flake:

```bash
nix flake check path:.
```

Then rebuild the active host using the normal local rebuild workflow.

After switching, confirm the installed CLI version:

```bash
codex --version
```

## Notes

- Do not add the external `codex-cli-nix` flake input back.
- Do not add Cachix configuration for Codex CLI.
- Do not add automated workflows for this update path.
- Keep `programs.codex` configuration unchanged unless the update requires a separate, intentional config change.
