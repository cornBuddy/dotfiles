#!/bin/bash

set -e

echo build suckless soft
for dir in ./suckless/*
do
    sudo make install -C "${dir}"
    sudo make clean -C "${dir}"
done

echo config xinit
ln -sf "$(pwd)/xinitrc" ~/.xinitrc
mkdir -p ~/.config/xkb

echo set up peripheral devices
ln -sf "$(pwd)/xkbconfig" ~/.config/xkb/my
sudo ln -sf $(pwd)/xorg/* /etc/X11/xorg.conf.d

echo configuring systemd
sudo ln -sf $(pwd)/systemd/logind.conf /etc/systemd/logind.conf
