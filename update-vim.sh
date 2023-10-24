#!/bin/bash
cd ~/vim
cp ~/.vimrc ~/vim/
cp ~/.zshrc ~/vim/
cp ~/.tigrc ~/vim/
cp ~/.config/coc/ultisnips/javascript.snippets ~/vim/
cp ~/.config/coc/ultisnips/typescript.snippets ~/vim/
cp ~/.config/ranger/rc.conf ~/vim/
cp ~/.config/ranger/rifle.conf ~/vim/
cp ~/.tmux.conf ~/vim/
git add .vimrc
git add .zshrc
git add ./base32.js
git add javascript.snippets
git add typescript.snippets
git add *
git add .*
git commit -m "Update vim"
git push

