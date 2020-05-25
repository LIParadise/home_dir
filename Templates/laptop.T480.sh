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
# echo "xrandr --output HDMI-2 --set \"Broadcast RGB\" \"Full\""
# xrandr --output HDMI-2 --set "Broadcast RGB" "Full"

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

# Display red shift
#
## myCurrentHourIn24H=$(date +%H)
## if [ ${myCurrentHourIn24H} -ge 20 ] || [ ${myCurrentHourIn24H} -le 4 ]
## then
##   echo ""
##   echo "Have a good night, ${USER}"
##   gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 20.0
##   gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to   7.0
## else
##   echo ""
##   echo "Have a nice day, ${USER}"
##   gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 0.0
##   gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to   23.983333333333331
## fi

# libinput gesture support in swaywm
## Need aur package "libinput-gestures-setup"
if [ "$(libinput-gestures-setup status | grep -i run | cut -d' ' -f3)" = "not" ]; then
  libinput-gestures-setup restart
fi