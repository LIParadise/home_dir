#!/usr/bin/env bash

# using `xargs` to help parallel-ize the `mkinitcpio` process
# this, however, makes output of different presets mix together
# one may turn to `GNU parallel` to retain output integrity.
find "/etc/mkinitcpio.d" -type f -iname "*.preset" -print0 | \
    xargs -0 -n 1 -P 8 mkinitcpio -p
