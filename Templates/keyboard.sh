#!/usr/bin/env sh

if [ ! "KDE" = "${XDG_CURRENT_DESKTOP}" ]; then
    echo "Sorry, but this tool support only KDE for now"
    exit 1
fi

if ! type kwriteconfig6 >/dev/null || ! type dbus-send >/dev/null; then
    echo 'Tool not found: `kwriteconfig6` and `dbus-send` both required!'
    exit 1
fi

if [ "${#}" -ne 1 ]; then
    echo "Usage: ${0} <[enable|disable]>"
    exit 1
fi

ENABLED=
haystack="enabled"  needle="$(printf "%s" "${1}" | tr '[:upper:]' '[:lower:]')" sh -c 'test "${haystack#"${needle}"}" != "${haystack}"' && ENABLED=true
haystack="disabled" needle="$(printf "%s" "${1}" | tr '[:upper:]' '[:lower:]')" sh -c 'test "${haystack#"${needle}"}" != "${haystack}"' && ENABLED=false

case "${ENABLED}" in
    false)
        kwriteconfig6 --file kxkbrc --group Layout --key Options --delete;;
    true)
        kwriteconfig6 --file kxkbrc --group Layout --key Options ctrl:swapcaps;;
    *)
        echo "Failed to parse, assume no-op, exit"
        exit 0;;
esac

case "${ENABLED}" in
    false|true)
        dbus-send --session --type=signal --reply-timeout=100 --dest=org.kde.keyboard /Layouts org.kde.keyboard.reloadConfig;;
    *)
        echo 'Unreachable!!!'
        exit 127;;
esac
