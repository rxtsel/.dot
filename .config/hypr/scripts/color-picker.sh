#!/bin/sh

color=$(hyprpicker -a 2>/dev/null || true)

if [ -n "$color" ] && [ "$color" != "null" ]; then
  notify-send "Color copied to clipboard" "$color"
fi
