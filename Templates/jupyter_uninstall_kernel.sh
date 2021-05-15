#!/usr/bin/env sh
ask_user_or_exit(){
    # if 'yes', continue following task
    # if 'no', exit.
    if [ "$#" -ne 1 ]; then
        echo "Bad usage of \`ask_user_or_exit\`"
        exit 1
    fi
    while true; do
        echo "You're sure you want this?"
        read -r -p "$1 " yes_or_no
        case $yes_or_no in
            [Yy]* ) break;;
            [Nn]* ) echo "Abort."; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

if [ "$#" -ne 1 ]; then
    echo "Bad usage. Need virtualenv name specified."
    exit 1
fi

have_kernel="$(jupyter kernelspec list | grep "$1")"
if [ "$have_kernel" = "" ]; then
    echo "No \"$1\" kernel found in jupyter. Abort."
    exit 1
else
    ask_user_or_exit "jupyter kernelspec uninstall $1"
    jupyter kernelspec uninstall "$1"
fi
