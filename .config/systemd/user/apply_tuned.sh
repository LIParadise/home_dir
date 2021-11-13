#!/usr/bin/env bash

# tuned-adm
my_ac_adapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)
sleep 0.2 # to ensure it's off or on.
echo "my_ac_adapter is ${my_ac_adapter}"
echo ""
if [ "${my_ac_adapter}" = "on" ]; then
    /usr/sbin/tuned-adm off
else
    /usr/sbin/tuned-adm profile laptop-battery-powersave
fi
/usr/sbin/tuned-adm active
echo "" # ignore exit status 1 when tuned-adm have no current profile
