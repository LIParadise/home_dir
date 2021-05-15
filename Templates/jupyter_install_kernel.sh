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

if [ "$VIRTUAL_ENV" = "" ]; then
    echo "You need to be in virtualenv!!!"
    exit 1
else
    echo "In virtualenv $VIRTUAL_ENV"
fi

echo ""
have_ipykernel="$(pip list | grep ipykernel)"
have_kernel="$(jupyter kernelspec list | grep "$(basename "$VIRTUAL_ENV")")"
if [ "$have_ipykernel" = "" ]; then
    echo "Try \`pip install ipykernel\` first"
    exit 1
elif ! [ "$have_kernel" = "" ]; then
    echo "Jupyter say \"$(echo "$have_kernel" | sed -r 's/[[:space:]]+/ /g' | sed -r 's/^[[:space:]]*//')\""
    echo "Kernel seem already installed. Abort."
    exit 1
else
    echo "ipykernel installed and jupyter kernel seem absent. Proceed."
fi

echo ""
ask_user_or_exit "ipython kernel install --user --name=\"$(basename "$VIRTUAL_ENV")\""
ipython kernel install --user --name="$(basename "$VIRTUAL_ENV")"
