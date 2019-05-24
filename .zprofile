# mbed-cli bash completion
# check the following:
# https://github.com/eddiezane/lunchy/issues/57
# for more details
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
source /home/liparadise/mbed/.bash_completion.d/mbed
# End of mbed-cli bash completion

# NTUOSC ml environmental variables
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/bin/virtualenvwrapper.sh
# end of NTUOSC ml environmental variables
