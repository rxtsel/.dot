#!/usr/bin/env zsh

# Wallpapers dir
wallpapers=$HOME/.dots/wallpapers

# Choose a random valid image (avoid non-image files)
random=$(find "$wallpapers" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | shuf -n 1)

# Validate that a random image was found
if [[ ! -f "$random" ]]; then
  echo "[ERROR]: Don't found image in $wallpapers"
  exit 1
fi

# Separate the image into two halves (left and right)
magick "$random" -crop 50%x100% +repage /tmp/output.png

# Show the left half on DP-1 and the right half on DP-2
swww img -o "DP-2" --transition-type random /tmp/output-0.png
swww img -o "DP-1" --transition-type random /tmp/output-1.png
