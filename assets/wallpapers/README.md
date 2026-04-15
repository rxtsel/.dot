# Wallpaper Registry

Wallpapers are kept in this repo and selected through `registry.nix`.
The service uses repo paths directly (for example `~/.dotfiles/assets/wallpapers/...`) instead of re-saving wallpapers to the Nix store on each change.

Appearance/theming notes: `assets/docs/appearance.md`.

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

## Naming

Use the file pattern `<name>-<width>x<height>.<ext>`.

- `single-1920x1080-v1.jpg`
- `chinatown-7680x4320.png`
- `flowers-1920x1080.jpeg`

Lowercase and no spaces.

## Add a new wallpaper

1. Put the file in the correct folder:
   - `packs/<pack>/dark/`
   - `packs/<pack>/light/`
2. Rename it using the naming convention.
3. Register it in `registry.nix` under:
    - `packs.<pack>.<mode>.wallpapers`
4. Add metadata fields for each entry:
    - `path`
    - `width`
    - `height`
    - `priority`
5. In `path`, point to the wallpaper file inside this repo.

`width` and `height` must match the real image size.

`priority` is only used as a tie-breaker when multiple candidates have the same area.

## Selection

Hosts pick wallpapers with:

- `my.host.wallpaper.pack`
- `my.host.wallpaper.mode`
- `my.host.wallpaper.name` (optional)
- `my.host.wallpaper.layoutPreference`
- `my.host.wallpaper.fallbackPolicy`

- If `name` is set, that exact filename must exist in `packs.<pack>.<mode>.wallpapers`.
- Selection is resolution-based. A candidate is valid when `width >= requiredWidth` and `height >= requiredHeight`.
- `layoutPreference = "auto"` uses the primary monitor resolution on single monitor setups, and span resolution (`sum(width)` x `max(height)`) on multi-monitor setups.
- If no candidate matches the target resolution and fallback is `repeat-single`, it retries with the primary monitor resolution.
- If the selected mode does not exist, it falls back to the opposite mode (`dark` <-> `light`).
