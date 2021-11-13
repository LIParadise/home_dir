#!/usr/bin/env sh
if [ "$VIRTUAL_ENV" = "" ]; then
    echo "You need to be in virtualenv!!!"
    exit 1
else
    echo "In virtualenv $VIRTUAL_ENV"
fi

python -m pip install --upgrade pip
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
