#!/bin/bash

set -e

echo set up peripheral devices
sudo ln -sf $(pwd)/xorg/* /etc/X11/xorg.conf.d

echo configuring systemd
sudo ln -sf $(pwd)/systemd/logind.conf /etc/systemd/logind.conf
