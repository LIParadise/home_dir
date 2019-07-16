#!/usr/bin/env bash
xrandr --newmode 65hz 188.00  1920 2048 2248 2576  1080 1083 1088 1124 -hsync +vsync
xrandr --addmode eDP-1 65hz
xrandr --output eDP-1 --mode 65hz
