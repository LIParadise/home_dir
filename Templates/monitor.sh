#!/usr/bin/env bash
watch -n 1 "\
  sensors -j 2>&1 |\
    grep -i -E -e \"package id 0\" -A 1 |\
    sed -r \"s/[[:blank:],{}]|//g\" &&\
  echo \"\" &&\
  lscpu | grep -iEe \"cpu mhz\" &&\
  echo \"\" &&\
  acpi -V | grep -iEe \"battery [0-1]\""
