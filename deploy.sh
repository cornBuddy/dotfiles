#!/bin/bash

set -e

echo build suckless soft
for dir in `ls ./suckless`
do
    sudo make install -C ./suckless/${dir}
    sudo make clean -C ./suckless/${dir}
done

echo set up nvim
mkdir -p ~/.config/nvim/after/ftplugin/
ln -sf `pwd`/ftplugin/* ~/.config/nvim/after/ftplugin/
ln -sf `pwd`/init.vim ~/.config/nvim/

echo set up tmux
ln -sf `pwd`/tmux.conf ~/.tmux.conf
mkdir -p ~/.tmuxinator
ln -sf `pwd`/tmuxinator/* ~/.tmuxinator/

echo set up bash
ln -sf `pwd`/bash/bash_aliases ~/.bash_aliases
ln -sf `pwd`/bash/bash_logout ~/.bash_logout
ln -sf `pwd`/bash/bash_profile ~/.bash_profile
ln -sf `pwd`/bash/bashrc ~/.bashrc

echo set up fish
mkdir -p ~/.config/fish/{completions,functions}
ln -sf `pwd`/fish/completions/* ~/.config/fish/completions/
ln -sf `pwd`/fish/functions/* ~/.config/fish/functions/
ln -sf `pwd`/fish/config.fish ~/.config/fish/config.fish

echo set up git
ln -sf `pwd`/gitconfig ~/.gitconfig

echo add default eslintrc file
mkdir -p ~/workspace
ln -sf `pwd`/eslintrc.json ~/workspace/.eslintrc.json

echo config xinit
ln -sf `pwd`/xinitrc ~/.xinitrc
mkdir -p ~/.config/xkb

echo set up keyboard
ln -sf `pwd`/keymaptable ~/keymaptable
ln -sf `pwd`/xkbconfig ~/.config/xkb/my

echo config dunst
mkdir -p ~/.config/dunst
ln -sf `pwd`/dunstrc ~/.config/dunst/
