#!/usr/bin/env bash
if [[ -z $DISPLAY ]] && [ "$(tty)" = "/dev/tty1" ] ; then
  export XMODIFIERS="@im=fcitx"
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XIM=fcitx
  export XIM_ARGS="-d -r"
  export XIM_PROGRAM=/usr/bin/fcitx
  export _JAVA_AWT_WM_NONREPARENTING=1 # for matlab in sway
  # export DEPENDS="ibus"
  # export XIM_PROGRAM_SETS_ITSELF_AS_DAEMON=yes
  exec env sway
fi
