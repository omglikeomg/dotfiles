#!/bin/bash

# CONFIGS:
##########

sudo apt install xterm
# Choose default terminal value
sudo update-alternatives --config x-terminal-emulator
# Reinstall bash completion
sudo apt install --reinstall bash-completion
# Install some fonts:
# Debian desactiva bitmap fonts por defecto...
cd /etc/fonts/conf.d/
sudo rm 10*
sudo rm -rf 70-no-bitmaps.conf
sudo ln -s ../conf.avail/70-yes-bitmaps.conf .
sudo dpkg-reconfigure fontconfig
# ahora sí
cd ~
git clone https://github.com/omglikeomg/bitmap-fonts.git
cd bitmap-fonts
sudo cp -avr bitmap/ /usr/share/fonts
# this makes sure it adds every font to x selectors
find /usr/share/fonts/bitmap/ -name fonts.dir | xargs dirname | xargs -I {} xset fp+ {}
fc-cache -fv

# Copiar los dotfiles incluidos
cd ~/
cd dotfiles
cp .bashrc ~/
cp -dru .config/ ~/
cp .Xresources ~/
cp .vimrc ~/
cp vimtips.txt ~/.vim
# Runs Vim and installs plugin manager so you can check everything's in order
vim -c "InstallPlug | :qa!"
vim -c "PlugInstall --sync | :qa!"

# install more useful software
sudo apt install cmus transmission transmission-cli vlc id3v2 shutter scrot

# youtube-dl
sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/bin/youtube-dl
sudo chmod 755 /usr/bin/youtube-dl
