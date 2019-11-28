#!/usr/bin/env bash
# myFolderName=$(pwd | sed -r 's/\/home\/liparadise\/Pictures\/plasma\/wallpapers\///' | sed -r 's/\/contents\/images//')
# echo ${myFolderName}
# for f in *.jpg; do
#   mv -- "${f}" "${myFolderName}_${f}"
# done

for folderName in $(ls -d */); do
  folderName=${folderName%\/}
  for imageName in $(ls ${folderName}/contents/images); do
    mv -- "${folderName}/contents/images/${imageName}" "${folderName}/contents/images/${folderName}_${imageName}"
  done
done
