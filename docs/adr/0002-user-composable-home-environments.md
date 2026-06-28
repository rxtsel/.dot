# ADR 0002: User-Composable Home Environments

- Status: Accepted
- Date: 2026-06-27

## Context

The previous Home Manager composition centered on shared profile bundles and a single global user option. That made the active hosts easy to configure, but it coupled reusable modules to one user identity and made future multi-user hosts harder to extend.

We want the repository to behave like a small platform: it provides reusable NixOS and Home Manager capabilities, while each host decides which local users exist and each user composes their own environment from those capabilities.

## Decision

Remove the singleton user model from shared modules.

- NixOS users are declared per host with `my.users`.
- Home Manager modules read per-user identity from `config.my.identity`.
- Hosts compose each user's Home Manager imports directly from `modules/home/`.
- Shared `profile*` Home Manager bundles are not part of the core architecture.

## Module scope rules

- `modules/nixos/` contains system/host/root-owned capabilities.
- `modules/home/` contains per-user Home Manager capabilities.
- `core/` is kept in both classes, but only for minimal foundational modules.
- Optional capabilities live outside `core/`.

## Consequences

- Adding a second user does not require changing shared modules.
- User identity is local to each Home Manager evaluation.
- Hosts remain explicit about system capabilities and user environments.
- There is less abstraction than profile/environment layers, but composition is clearer and more flexible.
