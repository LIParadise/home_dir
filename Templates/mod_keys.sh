#!/usr/bin/env bash

# Usage:
# Put "mac.json" and "pc.json" in WSL ${HOME}/Templates
#     where "mac.json" is PowerToys key mapping "default.json" for mac keyboards,
#     and "pc.json" being counterpart for genuine PC keyboards.
# Put "evil.bat" to wherever you like *in Windows*
#     and specify its *Windows path* in variable ${evil} below.
# Call the script with argv[1] being "mac" or "pc"

help(){
    echo "${1}"
    echo "exit now."
    exit 1
}

translate_win_path_to_wsl(){
    if [ "$#" -ne 1 ]; then
        exit 1
    fi
    P="$(cmd.exe /c echo ${1} | sed -r 's/\r|\://g' | sed -r 's/\\/\//g' | sed -r 's/(^.)/\/mnt\/\L\1/')"
    echo "${P}"
}

go_up_one_folder(){
    if [ "$#" -ne 1 ]; then
        exit 1
    fi
    P="${1//\\/\/}"
    P="${P%/*}"
    echo "${P}"
}

go_down_filesystem_to(){
    if [ "$#" -ne 2 ]; then
        exit 1
    fi
    echo "${1}/${2}"
}

KeyMap=""
if [ "$#" -eq 1 ]; then
    if [ "$1" = "mac" ]; then
        KeyMap="mac"
    elif [ "$1" = "pc" ]; then
        KeyMap="pc"
    fi
fi

# Evil Windows bat script to kill PowerToys.exe
# Specify path *in Windows* here
evil=''
pt="$(translate_win_path_to_wsl "%PROGRAMFILES%")"
pt="$(go_down_filesystem_to "${pt}" "PowerToys/PowerToys.exe")"
RelativePath="Local/Microsoft/PowerToys/Keyboard Manager/default.json"

if [ "${KeyMap}" = "" ]; then
    help "no keymap specified"
fi
if [ ! -f "$(translate_win_path_to_wsl ${evil})" ]; then
    help "evil not found"
fi

AppData=$(translate_win_path_to_wsl "%APPDATA%")
AppData=$(go_up_one_folder "${AppData}")
PT_KM_PATH=$(go_down_filesystem_to "${AppData}" "${RelativePath}")
# Basic sanity check:
# Supposedly evil bat would ask for elevated priviledges in order to kill PowerToys.exe
# We don't want it to be contaminated!
EVIL_SHA256=$(sha256sum "$(translate_win_path_to_wsl ${evil})" | cut -d' ' -f 1)
if [ ! "${EVIL_SHA256}" = "8de6ddab515f3449a63aab9a818450c8271af5e839e52e4b279784fc8ecf19e6" ]; then
    help "evil contaminated. exit."
fi

cmd.exe /c "call ${evil}"
cp "${PT_KM_PATH}" "${HOME}/Templates/old.json"
cp "${HOME}/Templates/${KeyMap}.json" "${PT_KM_PATH}"
while [ -n "$(cmd.exe /c 'tasklist' | grep PowerToys.exe)" ];
do
    sleep 1
done
eval "\"${pt}\""
