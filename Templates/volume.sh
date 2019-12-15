#!/usr/bin/env bash

# usage: volume.sh <num>
# to call pulseaudio to set volume to <num>
# example: volume.sh 10

new_volume="$1"

if [ "$new_volume" -ge 100 ] ; then
  pamixer -u
  pamixer --set-volume 100
elif [ "$new_volume" -gt 0 ] ; then
  pamixer -u
  pamixer --set-volume $new_volume
else
  pamixer -m
  pamixer --set-volume 0
fi
