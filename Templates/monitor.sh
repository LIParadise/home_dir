#!/usr/bin/env bash
watch -n 5 "sensors && lscpu | grep -iEe \"cpu mhz\""
