#!/bin/bash
apt install nvim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ~/vim/.vimrc ~/.vimrc
vim +PluginInstall +qall
chmod +x ./installNeovim.sh
./installNeovim.sh
mkdir ~/.config || mkdir ~/.config/nvim/ || cp ./init.vim ~/.config/nvim/
export VISUAL=nvim
export EDITOR="$VISUAL"
pip3 install ranger-fm pynvim
cp rifle.conf ~/.config/ranger/ && cp rc.conf ~/.config/ranger/
