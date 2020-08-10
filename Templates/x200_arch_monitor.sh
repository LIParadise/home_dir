#!/usr/bin/env sh
watch -n 1 "\
   sensors acpitz-acpi-0 2>&1 | grep temp | awk '{print \$1\" \"\$2}' &&\
   printf \"\n\" &&\
   \
   grep \"processor\|cpu MHz\" /proc/cpuinfo | rev | cut -d' ' -f 1 | rev | paste -d ' '  - - &&\
   printf \"\n\" &&\
   \
   acpi -b -i"
