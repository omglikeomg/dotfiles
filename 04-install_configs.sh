#!/bin/bash

# Copiar los dotfiles incluidos
cd ~/
cd dotfiles
cp .bashrc ~/
cp -dru .config/ ~/
cp .Xresources ~/
cp .vimrc ~/
cp vimtips.txt ~/.vim
cp .xsessionrc ~/
# Runs Vim and installs plugin manager so you can check everything's in order
vim -c "InstallPlug | :qa!"

# install more useful software
sudo apt install cmus transmission transmission-cli vlc id3v2 shutter scrot
sudo apt install qutebrowser qutebrowser-qtwebengine

# youtube-dl
sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/bin/youtube-dl
sudo chmod 755 /usr/bin/youtube-dl
