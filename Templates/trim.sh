#!/bin/bash
cd $HOME
fstrim=`which fstrim`
$fstrim -v / ; $fstrim -v /home; $fstrim -v /mnt/data
