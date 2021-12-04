# mbed-cli bash completion

# https://github.com/eddiezane/lunchy/issues/57
# for more details
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
# source /home/liparadise/.bash_completion.d/mbed
# End of mbed-cli bash completion

# NTUOSC ml environmental variables
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/bin/virtualenvwrapper.sh
# end of NTUOSC ml environmental variables
#

path=("/usr/local/bin" "$HOME/.cargo/bin" "$path[@]")
typeset -U PATH path
export PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
export ZDOTDIR="${HOME}/.zsh"

# Path for golang
# export GOPATH=$HOME/go

DISABLE_AUTO_UPDATE="true"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gentoo"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

## edit line in vim
export VISUAL="nvim"
autoload edit-command-line
zle -N edit-command-line

alias nv="nvim"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias lr="ls -tr"
alias ll="ls -alF"
alias tmux="tmux -u" # utf-8 support
alias kl="keychain -l"
alias ks="source ${HOME}/.keychain/${HOST}-sh"
alias tl="tmux ls"
alias ta="tmux a"
alias jkl="jupyter kernelspec list"
alias jku="jupyter kernelspec uninstall"
alias socker="sudo docker"
alias clangmake="CC=/usr/bin/clang CXX=/usr/bin/clang++ cmake"
alias rsavp="rsync -av --progress"

ks

function CD(){
    cd ${1}; cd $(pwd -P)
}

function reboot_to_windows () {
    grub_windows_entry=$(sudo grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "$grub_windows_entry" && sudo reboot
}

function copy() {
    cat ${1} | xclip -selection c
}

function liparadise_compile {
    myCompiler="${1}"
    myCompileFlags="${2}"
    myLinkFlags="${3}"

    myInputFilename=
    myObj_Ext=".o"
    myInputFilename_o=
    myCompiledOutput=

    if [ "$#" -eq 4 ]; then
        myInputFilename="${4%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="test"
    elif [ "$#" -eq 5 ]; then
        myInputFilename="${4%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="${5}"
    else
        echo "Usage: <compile> code.cc <executable>"
        echo "where \"code.cc\" is a simple C++ code,"
        echo "\"executable\" being final executable name"
        exit 1
    fi

    echo "${myCompiler} ${myCompileFlags} \"${4}\""
    eval ${myCompiler} ${myCompileFlags} "${4}"
    echo "${myCompiler} ${myLinkFlags} \"${myCompiledOutput}\" \"${myInputFilename_o}\""
    eval ${myCompiler} ${myLinkFlags} "${myCompiledOutput}" "${myInputFilename_o}"
}

function G++ {
    myCompiler="g++"
    myCompileFlags="--std=c++11 -Wall -O2 -march=native -mtune=native -c"
    myLinkFlags="-lpthread -o"

    liparadise_compile "${myCompiler}" "${myCompileFlags}" "${myLinkFlags}" "${@}"
}

function Clang++ {
    myCompiler="clang++"
    myCompileFlags="--std=c++11 -Wall -O2 -mtune=native -c"
    myLinkFlags="-lpthread -o"

    liparadise_compile "${myCompiler}" "${myCompileFlags}" "${myLinkFlags}" "${@}"
}

function G++0 {
    myCompiler="g++"
    myCompileFlags="--std=c++11 -Wall -O0 -g -c"
    myLinkFlags="-lpthread -o"

    liparadise_compile "${myCompiler}" "${myCompileFlags}" "${myLinkFlags}" "${@}"
}

function Clang++0 {
    myCompiler="clang++"
    myCompileFlags="--std=c++11 -Wall -O0 -g -c"
    myLinkFlags="-lpthread -o"

    liparadise_compile "${myCompiler}" "${myCompileFlags}" "${myLinkFlags}" "${@}"
}

function GCC {
    myCompiler="gcc"
    myCompileFlags="--std=c99 -Wall -O2 -march=native -mtune=native -c"
    myLinkFlags="-lpthread -o"

    liparadise_compile "${myCompiler}" "${myCompileFlags}" "${myLinkFlags}" "${@}"
}

function Clang {
    myCompiler="clang"
    myCompileFlags="--std=c99 -Wall -O2 -mtune=native -c"
    myLinkFlags="-lpthread -o"

    liparadise_compile "${myCompiler}" "${myCompileFlags}" "${myLinkFlags}" "${@}"
}

function GCC0 {
    myCompiler="gcc"
    myCompileFlags="--std=c99 -Wall -O0 -g -c"
    myLinkFlags="-lpthread -o"

    liparadise_compile "${myCompiler}" "${myCompileFlags}" "${myLinkFlags}" "${@}"
}

function Clang0 {
    myCompiler="clang"
    myCompileFlags="--std=c99 -Wall -O0 -g -c"
    myLinkFlags="-lpthread -o"

    liparadise_compile "${myCompiler}" "${myCompileFlags}" "${myLinkFlags}" "${@}"
}
