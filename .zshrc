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
source /etc/bash_completion.d/virtualenvwrapper
# end of NTUOSC ml environmental variables
#

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/liparadise/.oh-my-zsh"
export ZDOTDIR="/home/liparadise/.zsh"

# Path for golang
export GOPATH=$HOME/go

DISABLE_AUTO_UPDATE="true"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gentoo"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# Decided that syntax highlighting is cool
### need to clone
### https://github.com/zsh-users/zsh-autosuggestions
### https://github.com/zsh-users/zsh-syntax-highlighting.git
### into ${ZSH}
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# LIParadise Modifications

## edit line in vim
export VISUAL="vim"
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
alias socker="sudo docker"
alias clangmake="CC=/usr/bin/clang CXX=/usr/bin/clang++ cmake"

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
function G++ {

    myCompiler="g++"
    myCompileFlags="--std=c++11 -Wall -O2 -march=native -mtune=native -c"
    myLinkFlags="-lpthread -o"

    myInputFilename=
    myObj_Ext=".o"
    myInputFilename_o=
    myCompiledOutput=

    if [ "$#" = 1 ]
    then 
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="test"
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    elif [ "$#" = 2 ]
    then
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput=$2
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    else 
        echo "Usage: G++ code.cc <executable>"
        echo "where \"code.cc\" is a simple C++ code,"
        echo "\"executable\" being final executable name"
        return 0
    fi
}

function Clang++ {

    myCompiler="clang++"
    myCompileFlags="--std=c++11 -Wall -O2 -march=native -mtune=native -c"
    myLinkFlags="-lpthread -o"

    myInputFilename=
    myObj_Ext=".o"
    myInputFilename_o=
    myCompiledOutput=

    if [ "$#" = 1 ]
    then 
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="test"
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    elif [ "$#" = 2 ]
    then
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput=$2
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    else 
        echo "Usage: Clang++ code.cc <executable>"
        echo "where \"code.cc\" is a simple C++ code,"
        echo "\"executable\" being final executable name"
        return 0
    fi
}

function G++0 {

    myCompiler="g++"
    myCompileFlags="--std=c++11 -Wall -O0 -g -c"
    myLinkFlags="-lpthread -o"

    myInputFilename=
    myObj_Ext=".o"
    myInputFilename_o=
    myCompiledOutput=

    if [ "$#" = 1 ]
    then 
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="test"
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    elif [ "$#" = 2 ]
    then
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput=$2
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    else 
        echo "Usage: G++0 code.cc <executable>"
        echo "where \"code.cc\" is a simple C++ code,"
        echo "\"executable\" being final executable name"
        return 0
    fi
}

function Clang++0 {
    myCompiler="clang++"
    myCompileFlags="--std=c++11 -Wall -O0 -g -c"
    myLinkFlags="-lpthread -o"

    myInputFilename=
    myObj_Ext=".o"
    myInputFilename_o=
    myCompiledOutput=

    if [ "$#" = 1 ]
    then 
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="test"
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    elif [ "$#" = 2 ]
    then
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput=$2
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    else 
        echo "Usage: Clang++0 code.cc <executable>"
        echo "where \"code.cc\" is a simple C++ code,"
        echo "\"executable\" being final executable name"
        return 0
    fi
}


function GCC {
    myCompiler="gcc"
    myCompileFlags="--std=c99 -Wall -O2 -march=native -mtune=native -c"
    myLinkFlags="-lpthread -o"

    myInputFilename=
    myObj_Ext=".o"
    myInputFilename_o=
    myCompiledOutput=

    if [ "$#" = 1 ]
    then 
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="test"
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    elif [ "$#" = 2 ]
    then
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput=$2
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    else 
        echo "Usage: GCC code.cc <executable>"
        echo "where \"code.cc\" is a simple C++ code,"
        echo "\"executable\" being final executable name"
        return 0
    fi
}

function GCC0 {
    myCompiler="gcc"
    myCompileFlags="--std=c99 -Wall -O0 -g -c"
    myLinkFlags="-lpthread -o"

    myInputFilename=
    myObj_Ext=".o"
    myInputFilename_o=
    myCompiledOutput=

    if [ "$#" = 1 ]
    then 
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="test"
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    elif [ "$#" = 2 ]
    then
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput=$2
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    else 
        echo "Usage: GCC0 code.cc <executable>"
        echo "where \"code.cc\" is a simple C++ code,"
        echo "\"executable\" being final executable name"
        return 0
    fi
}

function Clang {
    myCompiler="clang"
    myCompileFlags="--std=c99 -Wall -O2 -march=native -mtune=native -c"
    myLinkFlags="-lpthread -o"

    myInputFilename=
    myObj_Ext=".o"
    myInputFilename_o=
    myCompiledOutput=

    if [ "$#" = 1 ]
    then 
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="test"
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    elif [ "$#" = 2 ]
    then
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput=$2
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    else 
        echo "Usage: Clang code.cc <executable>"
        echo "where \"code.cc\" is a simple C++ code,"
        echo "\"executable\" being final executable name"
        return 0
    fi
}

function Clang0 {
    myCompiler="clang"
    myCompileFlags="--std=c99 -Wall -O0 -g -c"
    myLinkFlags="-lpthread -o"

    myInputFilename=
    myObj_Ext=".o"
    myInputFilename_o=
    myCompiledOutput=

    if [ "$#" = 1 ]
    then 
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput="test"
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    elif [ "$#" = 2 ]
    then
        myInputFilename="${1%\.*}"
        myInputFilename_o=${myInputFilename}${myObj_Ext}
        myCompiledOutput=$2
        echo "${myCompiler} ${myCompileFlags} $1"
        eval ${myCompiler} ${myCompileFlags} $1
        echo "${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}"
        eval ${myCompiler} ${myLinkFlags} ${myCompiledOutput} ${myInputFilename_o}
    else 
        echo "Usage: Clang0 code.cc <executable>"
        echo "where \"code.cc\" is a simple C++ code,"
        echo "\"executable\" being final executable name"
        return 0
    fi
}



function dev-tmux {
    tmux -f "/home/liparadise/.tmux.conf" new-session -d -n editor 

    tmux new-window -n ___editor -c "${PWD}"
    # tmux split-window -h -c "${PWD}"
    # tmux selectp -t 0

    tmux new-window -n docker -c "${PWD}"
    # tmux split-window -h -c "${PWD}"
    # tmux selectp -t 0

    tmux new-window -n Documents -c "${PWD}"
    # tmux split-window -h -c "${PWD}"
    # tmux selectp -t 0

    tmux new-window -n HTML -c "${PWD}"
    # tmux split-window -h -c "${PWD}"
    # tmux selectp -t 0

    tmux new-window -n MISC_0 -c "${PWD}"
    # tmux split-window -h -c "${PWD}"
    # tmux selectp -t 0

    tmux new-window -n MISC_1 -c "${PWD}"
    # tmux split-window -h -c "${PWD}"
    # tmux selectp -t 0

    tmux new-window -n MISC_2 -c "${PWD}"
    # tmux split-window -h -c "${PWD}"
    # tmux selectp -t 0

    tmux new-window -n Exp -c "${PWD}"
    # tmux split-window -h -c "${PWD}"
    # tmux selectp -t 0

   # tmux new-window -n misc -c "${PWD}"

   tmux selectw -t 0
   tmux -2 attach-session -d
}

function myctags {

    msg="\n\
        Usage: mytags <your_path>\n\
        Where your_path is where you want to put the ctags file\n\
        ctags file would default have name \"tags\"\n\
        When no arg., myCompiledOutput would be \$HOME/.tags/tags\n"

    if [ "$#" = 1 ]
    then
        if [ ${1} =~ '--help' || ${1} =~ '-h' ]
        then
            # somehow this would match "--h", etc. ...
            echo ${msg}
            return 0
        else
            # relative_path=`echo ${1} | sed -r -E 's/(.*)\/\w+\/?$/\1/g'`

            tag_filename="/tags"
            relative_path="hello, world"
            tag_path="/tmp/tags"

            if [ ${1} =~ '\/$' ]
            then

                if [ -d ${1} ]
                then
                    echo "\nYou specified a diretory"
                    relative_path=`sed -r -E 's/\/+$//g' <<< ${1}`
                    tag_path=${relative_path}${tag_filename}
                else
                    echo "\nThe directory \"${1}\" specified DNE."
                    echo "Maybe check existence of parent directory"
                    echo ${msg}
                    return 0
                fi

            elif [ ${1} =~ '\w$' || ${1} =~ '\.{1,3}$' ]
            then
                # in zsh, "..." expands to "../.."

                echo "input: ${1}"
                relative_path=`sed -r -E 's/\/[^/]+$//g' <<< ${1}`

                if [ -d ${1} ]
                then
                    echo "\nYou specified a directory"
                    echo "use default name \"tags\" as myCompiledOutput"
                    tag_path=${1}${tag_filename}

                elif [ -f ${1} ]
                then
                    echo "\nYou specified a already-existent myInputFilename"
                    echo "ctags will use it as myCompiledOutput"
                    tag_path=${1}

                elif [ -d ${relative_path} ]
                then
                    echo "\nYou specified a new file"
                    echo "ctags would use it as myCompiledOutput"
                    tag_path=${1}
                else
                    echo "relative_path is:  $relative_path"
                    echo "\nThe directory or file \"${1}\" specified DNE."
                    echo "Maybe check existence of parent directory"
                    echo ${msg} 
                    return 0
                fi

            else
                echo "\nThe directory or file \"${1}\" specified is wierd."
                echo "Maybe check existence of parent directory"
                echo ${msg} 
                return 0
            fi

            echo ""
            echo "relative_path is:  $relative_path"
            echo "tag_path is:       $tag_path"
            echo "ctags --language-force=c++ --tag-relative=yes -f ${tag_path} -R src/* lib/* include/*"
            echo ""
            ctags --language-force=c++ --tag-relative=yes -f ${tag_path} -R src/* lib/* include/*
            echo ""
            return 0

        fi

    elif [ "$#" = 0 ]
    then
        echo "ctags --language-force=c++ --tag-relative=yes -f $HOME/.tags/tags -R src/* lib/* include/*"
        ctags --language-force=c++ --tag-relative=yes -f $HOME/.tags/tags -R src/* lib/* include/*
        echo ""
        return 0
    else
        echo ${msg}
        return 0
    fi
}
# End of LIParadise Modifications
