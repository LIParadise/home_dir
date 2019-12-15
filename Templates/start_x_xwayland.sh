#!/usr/bin/env bash
if [[ -z $DISPLAY ]] && [ "$(tty)" = "/dev/tty1" ] ; then
  export XMODIFIERS="@im=ibus" 
  export XIM=ibus export XIM_ARGS="-xrd" 
  export XIM_PROGRAM_SETS_ITSELF_AS_DAEMON=yes 
  export DEPENDS="ibus" 
  export XIM_PROGRAM=/usr/bin/ibus-daemon 
  export GTK_IM_MODULE=ibus 
  export QT_IM_MODULE=ibus 
  ${XIM_PROGRAM} ${XIM_ARGS}
  exec env sway
fi
