#!/bin/sh

color=$(hyprpicker -a 2>/dev/null || true)

if [ -n "$color" ] && [ "$color" != "null" ]; then
  notify-send -e -h string:x-canonical-private-synchronous:osd -t 3000 "Color copied to clipboard" "$color"
fi
