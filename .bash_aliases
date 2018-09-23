alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ll="ls -alF"
alias ressh="sudo service ssh --full-restart"
alias vm="ssh -p 2222 liparadise@127.0.0.1"

function G++ {
  if [ $# != 1 ]
  then 
    echo "Usage: G++ code.cc"
    echo "where \"code.cc\" is a simple C++ code"
    return 0
  fi
  filename="${1%.*}"
  obj_f=".o"
  filename_o=$filename$obj_f
  echo "g++ --std=c++11 -Wall -c $1"
  g++ --std=c++11 -Wall -c $1
  echo "g++ -o test $filename_o"
  g++ -o test $filename_o
}
