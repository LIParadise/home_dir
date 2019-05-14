#!/bin/bash

case "$1" in
suspend|suspend_hybrid|hibernate)
  /usr/sbin/tuned-adm off
    ;;
resume|thaw)
    ;;
esac
