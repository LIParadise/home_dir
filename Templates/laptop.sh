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

if [ -z "${DISPLAY}" ]; then
    setfont ter-332n
fi

# tuned-adm
my_ac_adapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)
sleep 0.08 # to ensure it's off or on.
echo "my_ac_adapter is ${my_ac_adapter}"
echo ""
if [ "${my_ac_adapter}" = "on" ]; then
    /usr/sbin/tuned-adm off
else
    /usr/sbin/tuned-adm profile laptop-battery-powersave
fi
myTunedAdmProfile=$(tuned-adm active | awk 'NF{ print $NF }')
case "${myTunedAdmProfile}" in
  *laptop*)
    echo -e "Power-Efficient Mode: ${myGreen}ON${myNoColour}"
    ;;
  profile.)
    echo -e "Power-Efficient Mode: ${myRed}OFF${myNoColour}"
    ;;
  *)
    echo -e "Power-Efficient Mode: ${myHiWhite}${myTunedAdmProfile}${myNoColour}"
    ;;
esac

if [ "$(command -v intel-undervolt)" ]; then
   sudo intel-undervolt apply
else
   echo "\`intel-undervolt\` not found"
fi

# libinput gesture support in swaywm
## Need aur package "libinput-gestures-setup"
# if [ "$(libinput-gestures-setup status | grep -i run | cut -d' ' -f3)" = "not" ]; then
#   libinput-gestures-setup restart
# fi
