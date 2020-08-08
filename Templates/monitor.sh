#!/usr/bin/env bash
watch -n 1 "\
   sensors -u 2>&1 |\
   grep -A 1 \"Package id 0\" | grep temp1_input | sed -r 's/[[:space:]]+temp1_input/CPU Package/' &&\
   echo \"\" &&\
   \
   cat /proc/cpuinfo | grep \"processor\|cpu MHz\" | perl -0777 -pe 's/processor[[:space:]]+:[[:space:]]+([[:digit:]]+).cpu MHz[[:space:]]+:[[:space:]]+([0-9.]+)/core\$1: \$2 MHz/gms' &&\
   echo \"\" &&\
   \
   acpi -V | grep Battery"
