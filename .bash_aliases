alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ll="ls -alF"
alias ressh="sudo service ssh --full-restart"
alias vm="ssh -p 2222 liparadise@127.0.0.1"

function G++ {
  if [ $# == 1 ]
  then 
    filename="${1%.*}"
    obj_ext=".o"
    filename_o=$filename$obj_ext
    echo "g++ --std=c++11 -Wall -c $1"
    g++ --std=c++11 -Wall -c $1
    echo "g++ -o test $filename_o"
    g++ -o test $filename_o
  elif [ $# == 2 ]
  then
    filename="${1%.*}"
    obj_ext=".o"
    filename_o=$filename$obj_ext
    echo "g++ --std=c++11 -Wall -c $1"
    g++ --std=c++11 -Wall -c $1
    echo "g++ -o $2 $filename_o"
    g++ -o $2 $filename_o
  else 
    echo "Usage: G++ code.cc <executable>"
    echo "where \"code.cc\" is a simple C++ code,"
    echo "\"executable\" being final output filename"
    return 0
  fi
}

function dev-tmux {
  tmux new-session -d -n vim
  tmux new-window -n files
  tmux new-window -n testing 
  tmux split-window -h
  tmux selectp -t 0
  tmux new-window -n misc
  tmux selectw -t 0
  tmux -2 attach-session -d
}
