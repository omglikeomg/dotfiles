#!/bin/bash

# i3 WINDOW MANAGER
###################
sudo echo 'test'
[ -f /etc/apt/sources.list ] && sudo echo "# debian testing packages (next stable)" >> /etc/apt/sources.list
[ -f /etc/apt/sources.list ] && sudo echo "deb http://http.es.debian.org/debian/ testing non-free contrib main" >> /etc/apt/sources.list
sudo apt update
sudo apt install xorg i3/testing i3status/testing i3blocks/testing suckless-tools i3lock/testing xbacklight feh rofi
sudo apt install lightdm

