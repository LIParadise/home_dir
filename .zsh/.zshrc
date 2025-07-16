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

# Enable `less` mouse support
export LESS='--mouse --wheel-lines=2 -R -i'

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

alias cp="cp -i"
alias git-no-mode="git -c core.fileMode=false status"
alias jkl="jupyter kernelspec list"
alias jku="jupyter kernelspec uninstall"
alias kl="keychain -l"
alias ks="source ${HOME}/.keychain/${HOST}-sh"
alias lr="ls -tr"
alias ll="ls -alF"
alias mv="mv -i"
alias nv="nvim"
alias nvc="nvim --clean +'set nu ai ic sc et sts=4 ts=4 hlsearch paste|colorscheme habamax'"
alias rsavp="rsync -av --progress"
alias rm="rm -i"
alias socker="sudo docker"
alias tmux="tmux -u" # utf-8 support
alias ta="tmux a"
alias tl="tmux ls"

# handy `git status` shortcut
function my_git_util() {
    local dir
    local action

    dir=""
    action=""

    case "${1}" in
        status) action="status -u";;
        diff) action="diff";;
        log) action="log";;
    esac
    [ -z "${action}" ] && echo "wrong usage" && return 1

    [ -z "${debug}" ] || echo "argument is now '${#}: ${*}'"
    case $# in
        1)
        {
            dir="."
            shift 1
        };;
        *)
        {
            [ -d "${2}" ] && dir="${2}"
            shift 2
        };;
    esac
    [ -z "${debug}" ] || echo "argument is now '${#}: ${*}'"

    # The `dir` variable must be either empty or valid directory
    #     (except in the rare case where local `.` is no longer present,
    #      e.g. after `git checkout` or `rm -rf`;
    #      in that case we'd like to know what's going on anyway)
    #
    # `git rev-parse --show-toplevel` gives git root folder of that repo
    # (note that it shows submodule root if submodule)
    # finally show `git` output
    #
    # Note that we use `eval` to enable genuine shell argument passing (splitting),
    # hence dangers that comes with `eval` applies.
    # More on word splitting:
    # https://unix.stackexchange.com/questions/419148
    [ -z "${dir}" ] && echo "\"${dir}\" not defined" || \
        printf "git ${action} for directory %s\n" "$(git -C "${dir}" rev-parse --show-toplevel)" && eval "git -C ${dir} ${action} ${*}"
}

alias gs="my_git_util status"
alias gd="my_git_util diff"
alias gl="my_git_util log"

function my_find_util {
    local dir
    local file_types
    local search_phrase
    dir=""
    file_types=""
    search_phrase=""


    if [ $# -eq 1 ] && [ -n "${1}" ]; then
        dir="."
        search_phrase="${1}"
    elif [ $# -eq 2 ] && [ -d "${1}" ] && [ -n "${2}" ]; then
        dir="${1}"
        search_phrase="${2}"
    elif [ $# -eq 3 ] && [ -d "${1}" ]; then
        dir="${1}"
        file_types="-name \"${2}\""
        search_phrase="${3}"
    elif [ $# -gt 3 ] && [ -d "${1}" ]; then
        dir="${1}"

        # POSIX hack to get last argument
        for __hack_get_last in "${@}"; do :; done
        search_phrase="${__hack_get_last}"

        # get all arguments except first and last
        # note that the spaces remain in the variable
        file_types="${*%"${search_phrase}"}"
        file_types="${file_types#"${dir}"}"
        # trim leading/trailing spaces
        file_types="$(printf '%s' "${file_types}" | awk '{$1=$1;print}')"
        # replace the space in between to '|'
        file_types="$(printf '%s' "${file_types}" | sed -E 's/[[:space:]]+/|/g')"
        echo "file_types is ${file_types}"
        file_types="$(printf '%s' "${file_types}" | sed -E 's#([^|]+)#-name "\1"#g')"
        echo "file_types is ${file_types}"
        file_types="$(printf '%s' "${file_types}" | sed -E 's/\|/ -or /g')"
        # finally add the parenthesis for `find`
        file_types="\\( ${file_types} \\)"
    fi

    if [ -n "${dir}" ] && [ -n "${search_phrase}" ]; then
        if [ -n "${MYSHELLDEBUG}" ]; then
            echo "dir is ${dir}"
            echo "file_types is ${file_types}"
            echo "search_phrase is ${search_phrase}"
            echo "<C-c> to cancel run"
            sleep 5
        fi
        local cmd
        cmd="find ${dir} -type f ${file_types} -print0 | xargs -0 -P7 grep -nH --color=always ${search_phrase}"
        type wl-copy  >/dev/null 2>&1 && printf '%s' "${cmd}" | wl-copy
        type clip.exe >/dev/null 2>&1 && printf '%s' "${cmd}" | clip.exe
        type xclip    >/dev/null 2>&1 && printf '%s' "${cmd}" | xclip -sel c
        echo 'Search command is in your clipboard, use e.g. "Shift + Insert"'
    else
        echo "unknown error"
        exit 1
    fi
}
alias google="my_find_util"

ks

function pgnd() {
    if [ "${#}" -eq 1 ] && ! [ -d "${1}" ] && ! [ -f "${1}" ]; then
        cargo new "${1}"
        if [ -d "${1}" ]; then
            if [ -d "${1}"/src ]; then
                touch "${1}"/src/lib.rs
            fi
            cd "${1}" || exit 69
        fi
    fi
}

function CD(){
    cd ${1}; cd $(pwd -P)
}

# function reboot_to_windows () {
#     grub_windows_entry=$(sudo grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
#     sudo grub-reboot "$grub_windows_entry"
#     sudo sync; sudo sync; sudo systemctl reboot
# }

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
