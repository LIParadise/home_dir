#!/usr/bin/env bash

# set xinput
# I dunno where we xinput reads its configuration files
# thus I put it here.
#
if [[ -n ${DISPLAY} ]]; then

command -v xinput >/dev/null 2>&1 || { echo >&2 "I require xinput but it's not installed.  Aborting."; exit 1; }

# check the following
# https://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script
# https://wiki.archlinux.org/index.php/TrackPoint#Middle_button_scroll
# for why this works.
# basically this is to prevent when "xinput" is absent
# the pros of this is it handles exit codes better then the commonly used util "which"
# and that this is posix-compatible.

xinput set-prop "Synaptics TM3276-022" "Device Accel Constant Deceleration" "2.5"

fi
#
# set xinput end
#
