#!/usr/bin/env bash
if [[ -z $DISPLAY ]] && [ "$(tty)" = "/dev/tty1" ] ; then
  exec env QT_WAYLAND_FORCE_DPI=physical GDK_BACKEND=wayland QT_QPA_PLATFORM=wayland-egl CLUTTER_BACKEND=wayland SDL_VIDEODRIVER=wayland BEMENU_BACKEND=wayland sway
fi
