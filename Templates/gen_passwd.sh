#!/usr/bin/env sh

if [ $# -eq 1 ] && [ "$1" -ge 1 ]; then
    LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c "$1"; echo
fi
