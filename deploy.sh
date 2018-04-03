#!/bin/bash

set -e

echo build suckless soft
for dir in `ls ./suckless`
do
    sudo make install -C ./suckless/${dir}
    sudo make clean -C ./suckless/${dir}
done

echo set up nvim
mkdir -p ~/.config/nvim/after
[ -d ~/.config/nvim/after/ftplugin ] && rm -rf ~/.config/nvim/after/ftplugin
ln -sf `pwd`/ftplugin ~/.config/nvim/after/ftplugin
ln -sf `pwd`/init.vim ~/.config/nvim/

echo set up tmux
ln -sf `pwd`/tmux.conf ~/.tmux.conf
rm -rf ~/.tmuxinator
ln -sf `pwd`/tmuxinator ~/.tmuxinator

echo set up bash
ln -sf `pwd`/bash/bash_aliases ~/.bash_aliases
ln -sf `pwd`/bash/bash_logout ~/.bash_logout
ln -sf `pwd`/bash/bash_profile ~/.bash_profile
ln -sf `pwd`/bash/bash_private_profile ~/.bash_private_profile
ln -sf `pwd`/bash/bashrc ~/.bashrc

echo set up zsh
ln -sf `pwd`/zsh/zshenv ~/.zshenv
ln -sf `pwd`/zsh/zshrc ~/.zshrc
ln -sf `pwd`/zsh/zsh_aliases ~/.zsh_aliases
ln -sf `pwd`/zsh/zshenv_private ~/.zshenv_private
ln -sf `pwd`/zsh/zsh_prompt ~/.zsh_prompt
ln -sf `pwd`/zsh/zlogout ~/.zlogout

echo set up git
ln -sf `pwd`/gitconfig ~/.gitconfig

echo config xinit
ln -sf `pwd`/xinitrc ~/.xinitrc
mkdir -p ~/.config/xkb

echo set up keyboard
ln -sf `pwd`/xkbconfig ~/.config/xkb/my

echo config dunst
mkdir -p ~/.config/dunst
ln -sf `pwd`/dunstrc ~/.config/dunst/

echo alacritty config
mkdir -p ~/.config/alacritty
ln -sf `pwd`/alacritty.yml ~/.config/alacritty
