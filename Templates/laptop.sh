#!/usr/bin/env bash

# Color ANSI
# https://en.wikipedia.org/wiki/ANSI_escape_code
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
myRed='\033[0;31m'
myGreen='\033[0;32m'
myHiWhite='\033[1m'
myNoColour='\033[0m'

if [ -z "${DISPLAY}" ]; then
    setfont ter-228n
fi

# tuned-adm
myTunedAdmProfile=$(tuned-adm active)
declaration="Power-Mode: "
case "${myTunedAdmProfile}" in
  *laptop*)
    echo -e "${declaration}${myGreen}${myTunedAdmProfile}${myNoColour}"
    ;;
  "No current active profile.")
    echo -e "${declaration}${myRed}${myTunedAdmProfile}${myNoColour}"
    ;;
  *)
    echo -e "${declaration}${myHiWhite}${myTunedAdmProfile}${myNoColour}"
    ;;
esac
