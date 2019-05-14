#!/bin/bash

case "$1" in
  suspend|suspend_hybrid|hibernate)
    /usr/sbin/tuned-adm off
    ;;
  resume|thaw)
    ac_adapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)
    if [ "$ac_adapter" = "on" ]; then
      /usr/sbin/tuned-adm off
    else
      /usr/sbin/tuned-adm profile laptop
    fi
    ;;
esac
