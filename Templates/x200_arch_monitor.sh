#!/usr/bin/env bash
watch -n 1 "\
   sensors -A 2>&1 | grep Core | awk '{print \$1\$2\" \"\$3}' &&\
   printf \"\n\" &&\
   \
   grep \"processor\|cpu MHz\" /proc/cpuinfo | rev | cut -d' ' -f 1 | rev | paste -d ' '  - - &&\
   printf \"\n\" &&\
   \
   acpi -b -i"
