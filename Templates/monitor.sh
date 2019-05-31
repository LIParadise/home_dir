#!/usr/bin/env bash
watch -n 5 "\
  sensors -j |\
    grep -iEe \"package id 0\" -A 1 |\
    sed -E -e \"s/[[:blank:],{}]|//g\" &&\
  echo \"\" &&\
  lscpu | grep -iEe \"cpu mhz\" &&\
  echo \"\" &&\
  acpi -V | grep -iEe \"battery [0-1]\""
