#!/usr/bin/env dash

# Idea:
# https://serverfault.com/a/481171

help_and_exit(){
    echo "Usage: ${0} <size> [<\"alphanumeric\">]"
    echo "    Generates a random string with given size."
    echo "    Default common alphanumeric and ASCII symbol"
    echo "    Append string (exactly) \"alphanumeric\" to trigger alphanumeric mode"
    exit 1
}

if [ "${#}" -eq 0 ] || [ "${#}" -ge 3 ] || ! [ "${1}" -eq "${1}" ] || ! [ "${1}" -ge 1 ]; then
    help_and_exit
fi

rnd_string_alphabet="a-zA-Z0-9~!@#$%^&*_-"

if [ "${#}" -eq 2 ]; then
    if [ "${2}" = "alphanumeric" ]; then
        rnd_string_alphabet="a-zA-Z0-9"
    else
        help_and_exit
    fi
fi

head -c $(($1 * 15)) /dev/urandom | \
    tr -dc "${rnd_string_alphabet}" | \
    fold -w "${1}" | \
    head -n 1
