#!/usr/bin/env bash
myFolderName=$(pwd | sed -r 's/\/home\/liparadise\/Pictures\/plasma\/wallpapers\///' | sed -r 's/\/contents\/images//')
# echo ${myFolderName}
for f in *.jpg; do
  g=$(echo ${f} | sed -r 's/^[^0-9]+([0-9]+)x([0-9]+)(.*)/ColdRipple_\1x\2\3/')
  mv ${f} ${g}
  # mv -- "${f}" "${myFolderName}_${f}"
done
