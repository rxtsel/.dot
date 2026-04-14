# Wallpaper Registry

This directory stores wallpapers in a structure that scales for:

- multiple hosts (`matebook-d15`, `blackout`, future hosts)
- automatic `dark`/`light` mode switching (for example with `darkman`)
- multiple monitor layouts (`single`, `dual-span`, and future layouts)

## Directory layout

```text
assets/wallpapers/
  README.md
  registry.nix
  packs/
    <pack>/
      dark/
      light/
```

## Naming convention

Runtime selection is metadata-driven via `registry.nix`, but file names should still be descriptive for easier browsing.

Recommended format:

`<layout>-<resolution>-<variant>.<ext>`

Examples:

- `single-1920x1080-v1.jpg`
- `dual-span-5120x1440-v1.jpg`
- `single-1920x1080-alt1.jpg`

Use lowercase and avoid spaces.

The file name is for humans; resolution matching and fallback behavior come from `registry.nix`.

## Add a new wallpaper

1. Put the file in the correct folder:
   - `packs/<pack>/dark/`
   - `packs/<pack>/light/`
2. Rename it using the naming convention.
3. Register it in `registry.nix` under:
   - `packs.<pack>.<mode>.layouts.<layout>`
4. Add metadata fields for each entry:
   - `path`
   - `width`
   - `height`
   - `priority`

The metadata in `registry.nix` should always match the actual image dimensions.

Only register files that actually exist. It is valid to have only one mode (`dark`) and one layout (`single`) at first.

## Host selection strategy

Hosts pick wallpapers with:

- `my.host.wallpaper.pack`
- `my.host.wallpaper.mode`
- `my.host.wallpaper.layoutPreference`
- `my.host.wallpaper.fallbackPolicy`

Current layouts:

- `single` for one monitor
- `dual-span` for a panoramic image across two monitors

When `layoutPreference = "auto"`:

- one monitor prefers `single`
- multiple monitors prefer `dual-span`

If the preferred layout has no matching wallpaper size, the current fallback is:

- `repeat-single`

If the selected mode does not exist for a pack, mode fallback tries the opposite mode (`dark` <-> `light`).

## TODO

- [ ] Add darkman hook to switch `my.host.wallpaper.mode`
- [ ] Restart `swaybg.service` when mode changes
- [ ] Add `per-output-<name>` layouts for multi-monitor split wallpapers
- [ ] Add real light wallpapers for packs that currently only have dark mode
- [ ] Add wallpaper selector menu integration (for example in Noctalia)
