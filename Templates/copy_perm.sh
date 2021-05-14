#!/usr/bin/env sh

if ! [ "$#" -eq 2 ] || ! [ -d "$1" ] || ! [ -d "$2" ]; then
    echo "Usage: $(basename $0) <dir1> <dir2>"
    echo ""
    echo "Synopsis: For all files in dir1, try copy permissions to corresponding file in dir2"
    echo "Example:  Suppose have file \"dir1/foo.txt\" being 644, \"dir2/foo.txt\" being 755"
    echo "          after script execution, \"dir2/foo.txt\" would be 644"
    echo "Note:     Directory structure shall be the same under dir1 and dir2"
    exit 1
fi

source_perm_dir="$1"
dest_perm_dir="$2"

# Use `realpath` instead of trying manually `sed`
# since e.g. script may be called as the following:
# `$0 ~/web ~/drive/web`
# where "~" may be interpreted as "/home/user", etc, by shell
# or any other bizzare location

find "$source_perm_dir" -type f \
    -exec sh -c 'chmod --reference=$1 $2/"$(realpath $1 --relative-to $3)" >/dev/null 2>&1 || true' sh {} "$dest_perm_dir" "$source_perm_dir" ';'
