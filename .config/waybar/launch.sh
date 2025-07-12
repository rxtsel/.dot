#!/bin/sh
killall waybar

waybar -c ~/.dot/.config/waybar/config &
-s ~/.dot/.config/waybar/style.css
