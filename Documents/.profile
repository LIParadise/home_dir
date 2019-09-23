# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set xinput
# I dunno where we xinput reads its configuration files
# thus I put it here.
#
if [[ -n ${DISPLAY} ]]; then

  command -v xinput >/dev/null 2>&1 || { echo >&2 "I require xinput but it's not installed.  Aborting."; exit 1; }

  # check the following
  # https://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script
  # https://wiki.archlinux.org/index.php/TrackPoint#Middle_button_scroll
  # for why this works.
  # basically this is to prevent when "xinput" is absent
  # the pros of this is it handles exit codes better then the commonly used util "which"
  # and that this is posix-compatible.

  xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Accel Constant Deceleration" "2.5"

fi
#
# set xinput end
#


