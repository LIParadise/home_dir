#!/usr/bin/env bash
# Overclock T480 built-in monitor to 70hz
xrandr --newmode 70hz 204.25  1920 2056 2256 2592  1080 1083 1088 1127 -hsync +vsync
xrandr --addmode eDP-1 70hz
xrandr --output eDP-1 --mode 70hz
