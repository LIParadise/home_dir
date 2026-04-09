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

sh -c "rustup self update && rustup update" &
if [ "$(nvim -v | rg NVIM | cut -d' ' -f2 | cut -d'.' -f2)" -ge 12 ]; then
    # neovim 0.12 built-in manager
    sh -c "nvim +'lua vim.pack.update()' +TSUpdate +qall" &
else
    # neovim 0.11 uses [vim-plug](https://github.com/junegunn/vim-plug)
    sh -c "nvim +PlugUpgrade +PlugUpdate +TSUpdate +qall" &
fi

simple_git_update "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" &
simple_git_update "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" &

wait
