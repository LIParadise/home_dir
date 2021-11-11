#!/usr/bin/env dash
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty3" ] ; then
   export XMODIFIERS="@im=fcitx"
   export GTK_IM_MODULE=fcitx
   export QT_IM_MODULE=fcitx
   export XIM=fcitx
   export XIM_ARGS="-rd"
   # ${XIM_PROGRAM} ${XIM_ARGS}
   # export DEPENDS="ibus"
   # export XIM_PROGRAM=/usr/bin/ibus-daemon
   # export XIM_PROGRAM_SETS_ITSELF_AS_DAEMON=yes
   exec env sway
fi
