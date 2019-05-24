#!/usr/bin/env bash

# Color ANSI
# check the following link:
# https://en.wikipedia.org/wiki/ANSI_escape_code
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# for more details
myRed='\033[0;31m'
myGreen='\033[0;32m'
myHiWhite='\033[1m'
myNoColour='\033[0m'

# xrandr HDMI
echo "xrandr --output HDMI-2 --set \"Broadcast RGB\" \"Full\""
xrandr --output HDMI-2 --set "Broadcast RGB" "Full"

# tuned-adm
myAcAdapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)
sleep 0.08 # to ensure it's off or on.
echo "myAcAdapter is ${myAcAdapter}"
echo ""
if [ "${myAcAdapter}" = "on" ]; then
  /usr/sbin/tuned-adm off
else
  /usr/sbin/tuned-adm profile laptop
fi

myTunedAdmProfile=$(tuned-adm active | awk 'NF{ print $NF }')
sleep 0.15
case "${myTunedAdmProfile}" in
  laptop)
    echo -e "Power-Efficient Mode: ${myGreen}ON${myNoColour}"
    ;;
  profile.)
    echo -e "Power-Efficient Mode: ${myRed}OFF${myNoColour}"
    ;;
  *)
    echo -e "Power-Efficient Mode: ${myHiWhite}${myTunedAdmProfile}${myNoColour}"
    ;;
esac

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

  xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Accel Constant Deceleration" "2.5"

fi
#
# set xinput end
#
