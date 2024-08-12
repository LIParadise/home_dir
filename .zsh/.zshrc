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

path=("$HOME/.cargo/bin" "/usr/local/bin" "$path[@]")
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
ZSH_THEME="evil_apple"

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
alias nvc="nvim --clean +'set nu ai ic sc et sts=4 ts=4 hlsearch paste|colorscheme slate'"
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
alias git-no-mode="git -c core.fileMode=false status"
alias git-push-new-branch="git push --set-upstream origin \$(git describe --all --exact-match | sed 's~heads/~~')"

# handy `git status` shortcut
function my_git_util() {
    dir=""
    action=""

    case "${1}" in
        status) action="status -u";;
        diff) action="diff";;
    esac
    [ -z "${action}" ] && echo "wrong usage" && exit 1

    case $# in
        1) dir=".";;
        2) [ -d "${2}" ] && dir="${2}";;
        3) [ "-C" = "${2}" ] && [ -d "${3}" ] && dir="${3}";;
    esac

    # The `dir` variable must be either empty or valid directory
    #     (except in the rare case where local `.` is no longer present,
    #      e.g. after `git checkout` or `rm -rf`;
    #      in that case we'd like to know what's going on anyway)
    #
    # `git rev-parse --show-toplevel` gives git root folder of that repo
    # (note that it shows submodule root if submodule)
    # finally show `git` output
    #
    # Note that we intentionlly allow word splitting for `action` by `$=action`, for e.g. `git status -u`
    # This is NOT portable but ZSH specific syntax!!!
    # https://unix.stackexchange.com/questions/419148
    [ -z "${dir}" ] && echo "\"${dir}\" not found" || printf "git ${action} for directory %s\n" "$(git -C "${dir}" rev-parse --show-toplevel)" && git -C "${dir}" "$=action"
}

alias gs="my_git_util status"
alias gd="my_git_util diff"

ks

function pgnd() {
    cargo new ${1}
    if [ -d ${1} ]; then
        if [ -d ${1}/src ]; then
            touch ${1}/src/lib.rs
        fi
        cd ${1}
    fi
}

function CD(){
    cd ${1}; cd $(pwd -P)
}

function reboot_to_windows () {
    grub_windows_entry=$(sudo grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "$grub_windows_entry"
    sudo sync; sudo sync; sudo systemctl reboot
}

# https://stackoverflow.com/a/8811800/9933842
# liparadise_contains(string, substring)
#
# Returns 0 if the specified string contains the specified substring,
# otherwise returns 1.
function liparadise_contains() {
    string="$1"
    substring="$2"
    if [ "${string#*"$substring"}" != "$string" ]; then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

function liparadise_wm_type() {
    loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}'
}

function copy() {
    local binaries=""
    grep -qi microsoft /proc/version && type 'clip.exe' >/dev/null && local binaries="${binaries}ms "
    [ "$(liparadise_wm_type)" = "wayland" ] && type 'wl-copy' >/dev/null && local binaries="${binaries}wl "
    xset q >/dev/null 2>&1 && type 'xclip' >/dev/null && local binaries="${binaries}x"
    if [ $# -eq "1" ] && [ -f "${1}" ]; then
        liparadise_contains "${binaries}" ms && clip.exe                   < "${1}"
        liparadise_contains "${binaries}" wl && wl-copy                    < "${1}"
        liparadise_contains "${binaries}" x  && xclip -selection clipboard < "${1}"
        return 0
    elif [ $# -eq "2" ] && [ -f "${1}" ] && [ "${2}" -eq "${2}" ]; then
        liparadise_contains "${binaries}" ms && sed -n "${2},${2}p" "${1}" | clip.exe
        liparadise_contains "${binaries}" wl && sed -n "${2},${2}p" "${1}" | wl-copy
        liparadise_contains "${binaries}" x  && sed -n "${2},${2}p" "${1}" | xclip -sel c
        return 0
    elif [ $# -eq "3" ] && [ -f "${1}" ] && [ "${2}" -lt "${3}" ]; then
        liparadise_contains "${binaries}" ms && sed -n "${2},${3}p" "${1}" | clip.exe
        liparadise_contains "${binaries}" wl && sed -n "${2},${3}p" "${1}" | wl-copy
        liparadise_contains "${binaries}" x  && sed -n "${2},${3}p" "${1}" | xclip -sel c
        return 0
    fi
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
