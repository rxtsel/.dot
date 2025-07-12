#!/bin/bash

if uwsm check may-start; then
    exec uwsm start hyprland-uwsm.desktop
fi
