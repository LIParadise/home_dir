#!/usr/bin/env sh

# Find all audio files and add them to playlist
#
# TODO: Add switches to determine which are music folder
#       which are playlist output, and if asking help,
#       Such that can work on multiple music folders
#       and specify manually playlist output filename

simple_help_and_exit() {
  echo "Usage: $0 Music_Folder" >&2
  echo "Usage: $0 Music_Folder Playlist_Folder" >&2
  exit 1
}

if   [ "$#" -eq 1 ] && [ -d "$1" ]; then
    playlist_folder=""
elif [ "$#" -eq 2 ] && [ -d "$1" ] && [ -d "$2" ]; then
    playlist_folder="$2/"
else
    simple_help_and_exit
fi

# remove possible trailing "/"
playlist_name="$(echo "$1" | sed -r "s/\/?$//" | sed -r "s/.*\/(.*)/\1/")"

find "$1" -type f                                                            \
    -exec sh -c 'file "$1" | grep -i -q "audio"' sh {} ';'                   \
    -exec sh -c 'echo "$1" >> "$2$3.m3u"' sh {} "$playlist_folder" "$playlist_name" ';'
