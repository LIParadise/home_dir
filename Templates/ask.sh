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
        read -p "$1 " yes_or_no
        case $yes_or_no in
            [Yy]* ) break;;
            [Nn]* ) echo "Abort."; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

ask_user_or_exit "You want pizza?"
echo "Okay here's one."
