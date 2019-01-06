# If you come from bash you might have to change your $PATH.
  # export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/liparadise/.oh-my-zsh"
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
plugins=(
git
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
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ll="ls -alF"
alias ressh="sudo service ssh --full-restart"
alias vm="ssh -p 2222 liparadise@127.0.0.1"

function G++ {
  if [ "$#" = 1 ]
  then 
    filename="${1%\.*}"
    obj_ext=".o"
    filename_o=${filename}${obj_ext}
    output="test"
    echo "g++ --std=c++11 -Wall -O2 -c $1"
    g++ --std=c++11 -Wall -O2 -c $1
    echo "g++ -o test $filename_o"
    g++ -o ${output} $filename_o
  elif [ "$#" = 2 ]
  then
    filename="${1%\.*}"
    obj_ext=".o"
    filename_o=${filename}${obj_ext}
    echo "g++ --std=c++11 -Wall -O2 -c $1"
    g++ --std=c++11 -Wall -O2 -c $1
    echo "g++ -o $2 $filename_o"
    g++ -o $2 $filename_o
  else 
    echo "Usage: G++ code.cc <executable>"
    echo "where \"code.cc\" is a simple C++ code,"
    echo "\"executable\" being final output filename"
    return 0
  fi
}

function Clang++ {
  if [ "$#" = 1 ]
  then 
    filename="${1%\.*}"
    obj_ext=".o"
    filename_o=${filename}${obj_ext}
    output="test"
    echo "clang++ --std=c++11 -Wall -O2 -c $1"
    clang++ --std=c++11 -Wall -O2 -c $1
    echo "clang++ -o test $filename_o"
    clang++ -o ${output} $filename_o
  elif [ "$#" = 2 ]
  then
    filename="${1%\.*}"
    obj_ext=".o"
    filename_o=${filename}${obj_ext}
    echo "clang++ --std=c++11 -Wall -O2 -c $1"
    clang++ --std=c++11 -Wall -O2 -c $1
    echo "clang++ -o $2 $filename_o"
    clang++ -o $2 $filename_o
  else 
    echo "Usage: Clang++ code.cc <executable>"
    echo "where \"code.cc\" is a simple C++ code,"
    echo "\"executable\" being final output filename"
    return 0
  fi
}

function G++0 {
  if [ "$#" = 1 ]
  then 
    filename="${1%\.*}"
    obj_ext=".o"
    filename_o=${filename}${obj_ext}
    output="test"
    echo "g++ --std=c++11 -Wall -O0 -c $1"
    g++ --std=c++11 -Wall -O0 -c $1
    echo "g++ -o test $filename_o"
    g++ -o ${output} $filename_o
  elif [ "$#" = 2 ]
  then
    filename="${1%\.*}"
    obj_ext=".o"
    filename_o=${filename}${obj_ext}
    echo "g++ --std=c++11 -Wall -O0 -c $1"
    g++ --std=c++11 -Wall -O0 -c $1
    echo "g++ -o $2 $filename_o"
    g++ -o $2 $filename_o
  else 
    echo "Usage: G++ code.cc <executable>"
    echo "where \"code.cc\" is a simple C++ code,"
    echo "\"executable\" being final output filename"
    return 0
  fi
}

function Clang++0 {
  if [ "$#" = 1 ]
  then 
    filename="${1%\.*}"
    obj_ext=".o"
    filename_o=${filename}${obj_ext}
    output="test"
    echo "clang++ --std=c++11 -Wall -O0 -c $1"
    clang++ --std=c++11 -Wall -O0 -c $1
    echo "clang++ -o test $filename_o"
    clang++ -o ${output} $filename_o
  elif [ "$#" = 2 ]
  then
    filename="${1%\.*}"
    obj_ext=".o"
    filename_o=${filename}${obj_ext}
    echo "clang++ --std=c++11 -Wall -O0 -c $1"
    clang++ --std=c++11 -Wall -O0 -c $1
    echo "clang++ -o $2 $filename_o"
    clang++ -o $2 $filename_o
  else 
    echo "Usage: clang++ code.cc <executable>"
    echo "where \"code.cc\" is a simple C++ code,"
    echo "\"executable\" being final output filename"
    return 0
  fi
}

function dev-tmux {
  tmux new-session -d -n vim

  tmux new-window -n files
  tmux split-window -h
  tmux selectp -t 0

  tmux new-window -n testing 
  tmux split-window -h
  tmux selectp -t 0

  tmux new-window -n misc

  tmux selectw -t 0
  tmux -2 attach-session -d
}

function myctags {

  msg="\n\
    Usage: mytags <your_path>\n\
    Where your_path is where you want to put the ctags file\n\
    ctags file would default have name \"tags\"\n\
    When no arg., output would be \$HOME/.tags/tags\n"

  if [ "$#" = 1 ]
  then
    if [[ ${1} =~ '--help' || ${1} =~ '-h' ]]
    then
      # somehow this would match "--h", etc. ...
      echo ${msg}
      return 0
    else
      # relative_path=`echo ${1} | sed -r -E 's/(.*)\/\w+\/?$/\1/g'`

      tag_filename="/tags"
      relative_path="hello, world"
      tag_path="/tmp/tags"

      if [[ ${1} =~ '\/$' ]]
      then

        if [[ -d ${1} ]]
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

      elif [[ ${1} =~ '\w$' || ${1} =~ '\.{1,3}$' ]]
      then
        # in zsh, "..." expands to "../.."

        echo "input: ${1}"
        relative_path=`sed -r -E 's/\/[^/]+$//g' <<< ${1}`

        if [[ -d ${1} ]]
        then
          echo "\nYou specified a directory"
          echo "use default name \"tags\" as output"
          tag_path=${1}${tag_filename}

        elif [[ -f ${1} ]]
        then
          echo "\nYou specified a already-existent filename"
          echo "ctags will use it as output"
          tag_path=${1}

        elif [[ -d ${relative_path} ]]
        then
          echo "\nYou specified a new file"
          echo "ctags would use it as output"
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
