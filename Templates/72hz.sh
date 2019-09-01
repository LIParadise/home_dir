#!/usr/bin/env bash
xrandr --newmode "72hz" 210.25  1920 2056 2256 2592  1080 1083 1088 1128 -hsync +vsync
xrandr --addmode eDP1 72hz
xrandr --output eDP1 --mode "72hz"
