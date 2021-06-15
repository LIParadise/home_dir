#!/usr/bin/env sh
if [ "$(id -u)" -ne 0 ]; then
    echo "Needs \`sudo\`"
    exit 1
fi

if [ "$#" -ne 1 ] || ! [ "$1" -eq "$1" ]; then
    echo "Usage: ./$(basename "${0}") <brightness>"
    exit 1
fi

backlight_max=""
backlight_file=""

intel_backlight_max="/sys/class/backlight/intel_backlight/max_brightness"
intel_backlight_file="/sys/class/backlight/intel_backlight/brightness"
if [ -f "$intel_backlight_max" ] && [ -f "$intel_backlight_file" ]; then
    backlight_max="$intel_backlight_max"
    backlight_file="$intel_backlight_file"
else
    echo "No known way controlling backlight; abort."
    exit 1
fi

max_brightness="$(cat ${backlight_max})"
brightness="$1"
if [ "$brightness" -ge "$max_brightness" ]; then
    brightness="$max_brightness"
elif [ "$brightness" -le 0 ]; then
    brightness="0"
fi
echo "$brightness" > "$backlight_file"
