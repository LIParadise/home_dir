#!/usr/bin/env bash
mv plug.vim plug.vim.bak
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ -f plug.vim ]; then
  rm plug.vim.bak
fi
