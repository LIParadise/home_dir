#!/usr/bin/env sh
watch -n 1 "\
   acpi -t | sed -r 's/ok, //' &&\
   printf \"\n\" &&\
   \
   grep \"processor\|cpu MHz\" /proc/cpuinfo | rev | cut -d' ' -f 1 | rev | paste -d ' '  - - &&\
   printf \"\n\" &&\
   \
   acpi -b -i"
