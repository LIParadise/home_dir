#!/usr/bin/env dash
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty3" ] ; then
   exec env sway
fi
