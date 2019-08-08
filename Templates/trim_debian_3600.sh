#!/bin/bash
cd $HOME
fstrim=`which fstrim`
$fstrim -v /
$fstrim -v /mnt/mx500
$fstrim -v /mnt/660p
$fstrim -v /home
$fstrim -v /boot
$fstrim -v /boot/efi
