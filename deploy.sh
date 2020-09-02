#!/bin/bash

set -e

echo set up peripheral devices
ln -sf "$(pwd)/xkbconfig" ~/.config/xkb/my
sudo ln -sf $(pwd)/xorg/* /etc/X11/xorg.conf.d

echo configuring systemd
sudo ln -sf $(pwd)/systemd/logind.conf /etc/systemd/logind.conf
