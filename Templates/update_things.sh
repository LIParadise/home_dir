#!/usr/bin/env sh

simple_git_update(){
    if [ $# -eq 1 ] && [ -d "${1}" ]; then
        dir="${1}"
    elif [ $# -eq 0 ] && [ -d "." ]; then
        dir="."
    else
        exit 1
    fi
    git -C "${dir}" remote -v update
    git -C "${dir}" pull
}

rustup self update && rustup update &

simple_git_update "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" &
simple_git_update "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" &

nvim +PlugUpgrade +PlugUpdate +TSUpdate +qall &

wait
