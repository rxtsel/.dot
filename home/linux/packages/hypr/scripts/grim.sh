#!/usr/bin/env zsh

# Directory to save screenshots
DIR="$HOME/Pictures/screenshots/"

# Validate if the directory exists, if not, create it
mkdir -p "$DIR"

# Generate the filename with the current timestamp
FILENAME="$DIR"$(date +'%s_grim.png')

if grim -g "$(slurp)" "$FILENAME"; then
  # If the screenshot was successful, copy the path to the clipboard
  cat "$FILENAME" | wl-copy

  # Notify success
  notify-send "Screenshot" "Screenshot copied to clipboard and saved." -t 5000 -a "ss"
fi
