#!/usr/bin/env sh
watch -n 2.0 "\
    printf \"[CPU]\n\" &&\
    grep \"MHz\" /proc/cpuinfo | awk 'BEGIN {ORS=\" \"}; {print \$4}' | sed -r 's/\.[[:digit:]]+//g' &&\
    printf \"\n\n\" &&\
    \
    sensors k10temp-pci-00c3 &&\
    \
    nvidia-smi -q -d clock | grep -e \"^[[:space:]]\+Clocks$\" -A2 | sed -r 's/^[[:space:]]+//g; s/Clocks/[GPU]/'"
