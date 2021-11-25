#!/usr/bin/env zsh

simple_git_update(){
    git remote -v update
    git pull
}

rustup self update && rustup update &

cd ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
simple_git_update &
cd ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
simple_git_update &
cd

nvim +PlugUpgrade +qall
nvim +PlugUpdate  +qall
nvim +CocUpdate   +qall

wait
