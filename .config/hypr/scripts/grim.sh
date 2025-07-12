#!/bin/sh

# Directory to save screenshots
DIR="$HOME/Pictures/screenshots"

# Validate if the directory exists, if not create it
mkdir -p "$DIR"

# Generate the filename with the current timestamp
FILENAME="$DIR"$(date + '%s_grim.png')

if grim -g "$(slurp)" "$FILENAME"; then
  # If the screenshot command is successful, copy the path to clipboard
  cat "$FILENAME" | wl-copy

  # Notify the user of success
  notify-send "Screenshot" "Screenshot saved to $FILENAME and copied to clipboard"
fi
