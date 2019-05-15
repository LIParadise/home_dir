#!/usr/bin/env bash

myac_adapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)
sleep 0.1 # to ensure it's off or on.
echo "myac_adapter is $myac_adapter"
if [ "$myac_adapter" = "on" ]; then
  echo "switching off power-efficiency mode"
  /usr/sbin/tuned-adm off
else
  echo "switching on power-efficiency mode"
  /usr/sbin/tuned-adm profile laptop
fi
