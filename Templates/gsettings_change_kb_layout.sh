#!/usr/bin/env bash

# Usage:
# Put "mac.gsettings" and "pc.gsettings" in ${HOME}/Templates
#     where "*.gsettings" is Gnome keyboard options
#     via `gsettings get org.gnome.desktop.input-sources xkb-options`
# Call the script with argv[1] being "mac" or "pc"

help(){
    echo "${1}"
    echo "exit now."
    exit 1
}

KeyMap=""
if [ "$#" -eq 1 ]; then
    if [ "$1" = "mac" ]; then
        KeyMap="mac"
    elif [ "$1" = "pc" ]; then
        KeyMap="pc"
    fi
fi

if [ "${KeyMap}" = "" ]; then
    help "no keymap specified"
fi

KeyMapFile="${KeyMap}.gsettings"
KeyMapFolder="${HOME}/Templates/"
KeyMapContent="$(cat ${KeyMapFolder}/${KeyMapFile} | tr -d '\n')"

gsettings set org.gnome.desktop.input-sources xkb-options "${KeyMapContent}"
