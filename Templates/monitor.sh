#!/usr/bin/env sh
watch -n 1.8 "\
   acpi -t &&\
   printf \"\n\" &&\
   \
   grep \"MHz\" /proc/cpuinfo | awk '{print \$4}' &&\
   printf \"\n\" &&\
   \
   acpi -b -i"
