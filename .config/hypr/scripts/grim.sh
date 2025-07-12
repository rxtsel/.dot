#!/bin/sh

# Directory to save screenshots
DIR="$HOME/Pictures/screenshots"

# Validate if the directory exists, if not create it
mkdir -p "$DIR"

# Generate the filename with the current timestamp
FILENAME="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"

if grim -g "$(slurp)" "$FILENAME"; then
  # If the screenshot command is successful, copy the path to clipboard
  cat "$FILENAME" | wl-copy

  # Notify the user of success
  notify-send "Screenshot" "Saved to: $FILENAME\n\n<b>Screenshot copied to clipboard</b>" -i "$FILENAME" -t 5000
fi
