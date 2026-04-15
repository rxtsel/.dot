# Wallpaper Registry

Wallpapers are kept in this repo and selected through `registry.nix`.
The service uses repo paths directly (for example `~/.dotfiles/assets/wallpapers/...`) instead of re-saving wallpapers to the Nix store on each change.

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

Use descriptive names such as:

- `single-1920x1080-v1.jpg`
- `dual-span-5120x1440-v1.jpg`

Lowercase and no spaces.

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
5. In `path`, point to the wallpaper file inside this repo.

`width` and `height` must match the real image size.

## Selection

Hosts pick wallpapers with:

- `my.host.wallpaper.pack`
- `my.host.wallpaper.mode`
- `my.host.wallpaper.layoutPreference`
- `my.host.wallpaper.fallbackPolicy`

- `layoutPreference = "auto"` chooses `single` with one monitor and `dual-span` with multiple monitors.
- If no candidate matches size in the target layout and fallback is `repeat-single`, it reuses the best `single` wallpaper.
- If the selected mode does not exist, it falls back to the opposite mode (`dark` <-> `light`).
