#!/usr/bin/env bash
watch -n 1 "\
   sensors -u 2>&1 | grep -A 1 \"Package id 0\" | grep temp1_input | rev | cut -d ' ' -f1 | rev | awk '{print \"CPU Package: \" \$0}' &&\
   printf \"\n\" &&\
   \
   grep \"processor\|cpu MHz\" /proc/cpuinfo | rev | cut -d' ' -f 1 | rev | paste -d ' '  - - &&\
   printf \"\n\" &&\
   \
   acpi -V | grep Battery"
