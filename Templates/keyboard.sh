#!/usr/bin/env sh

# so-called "strict mode"
# https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set -eux # -o pipefail... except it's not POSIX

if [ ! "KDE" = "${XDG_CURRENT_DESKTOP}" ]; then
    echo "Sorry, but this tool support only KDE for now"
    exit 1
fi

if ! type kwriteconfig6 >/dev/null || ! type dbus-send >/dev/null; then
    echo 'Tool not found: `kwriteconfig6` and `dbus-send` both required!'
    exit 1
fi

if [ "${#}" -ne 1 ]; then
    echo "Usage: ${0} <[enable|disable|toggle]>"
    exit 1
fi

ACTION=
haystack="enable"  needle="$(printf "%s" "${1}" | tr '[:upper:]' '[:lower:]')" sh -c 'test "${haystack#"${needle}"}" != "${haystack}"' && ACTION="enable"
haystack="toggle"  needle="$(printf "%s" "${1}" | tr '[:upper:]' '[:lower:]')" sh -c 'test "${haystack#"${needle}"}" != "${haystack}"' && ACTION="toggle"
haystack="disable" needle="$(printf "%s" "${1}" | tr '[:upper:]' '[:lower:]')" sh -c 'test "${haystack#"${needle}"}" != "${haystack}"' && ACTION="disable"

substr_contains() {
    string="$1"
    substring="$2"
    if [ "${string#*"$substring"}" != "$string" ]; then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

case "${ACTION}" in
    "disable")
        # TODO delete only the ctrl/caps swap functionality
        kwriteconfig6 --notify --file kxkbrc --group Layout --key Options --delete;;
    "enable")
        kwriteconfig6 --notify --file kxkbrc --group Layout --key Options ctrl:swapcaps;;
    "toggle")
        if substr_contains "$(kreadconfig6 --file kxkbrc --group Layout --key Options)" "ctrl:swapcaps"; then
            kwriteconfig6 --notify --file kxkbrc --group Layout --key Options --delete
        else
            kwriteconfig6 --notify --file kxkbrc --group Layout --key Options ctrl:swapcaps
        fi;;
    *)
        echo "Failed to parse, assume no-op, exit"
        exit 0;;
esac

case "${ACTION}" in
    "enable"|"disable"|"toggle")
        dbus-send --session --type=signal --reply-timeout=120 --dest=org.kde.keyboard /Layouts org.kde.keyboard.reloadConfig;;
    *)
        echo 'Unreachable!!!'
        exit 127;;
esac
