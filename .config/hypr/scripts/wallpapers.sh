#!/bin/sh

# Wallpapers dir
WALLPAPERS_DIR="$HOME/.dot/wallpapers"

# Choose a random valid image (avoid non-image files)
RAMDOM=$(find "$WALLPAPERS_DIR" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | shuf -n 1)

# Validate that a random image was found
if [[ ! -f "$RAMDOM" ]]; then
  echo "[ERROR]: No valid wallpapers found in $WALLPAPERS_DIR"
  exit 1
fi

# Only for two display setups
# Separate the image into two halves (left and right)
magick "$RAMDOM" -crop 50%x100% +repage /tmp/output.png
swww img -o "DP-2" --transition-type ramdon /tmp/output-0.png
swww img -o "DP-1" --transition-type ramdon /tmp/output-1.png

# For single display setups, comment the above lines and use this instead
# swww img --transition-type ramdon "$RAMDOM"
