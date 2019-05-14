#!/usr/bin/env bash

case "$1" in
  pre)
    /usr/sbin/tuned-adm off
    sleep 2s # to ensure it's off.
    ;;
  post)
    myac_adapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)
    if [ "$myac_adapter" = "on" ]; then
      /usr/sbin/tuned-adm off
    else
      /usr/sbin/tuned-adm profile laptop
    fi
    ;;
  *)
    echo "wait that's illegal; check 99-my_tuned_adm_modifier.sh" > /home/liparadise/tmp/my_tuned_adm_modifier_log.txt
    chown liparadise:liparadise /home/liparadise/tmp/my_tuned_adm_modifier_log.txt
    ;;
esac
