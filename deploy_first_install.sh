#!/bin/bash

# i3 WINDOW MANAGER
###################
sudo echo "# debian testing packages (next stable)" >> /etc/apt/sources.list
sudo echo "deb http://http.us.debian.org/debian/ testing non-free contrib main" >> /etc/apt/sources.list
sudo apt update
sudo apt install xorg i3/testing i3status/testing i3blocks/testing suckless-tools i3lock/testing xbacklight feh rofi
sudo apt install lightdm

# VIM
#####
# deb distro
sudo apt remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
 
# Everything needed for compiling + git + curl
 sudo apt install liblua5.1-dev \
   luajit libluajit-5.1 python-dev ruby-dev libperl-dev \
   libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev \
   libxt-dev python3-dev curl

sudo apt autoremove

#Optional: so vim can be uninstalled again via `dpkg -r vim`
sudo apt install checkinstall

sudo rm -rf /usr/local/share/vim /usr/bin/vim

cd ~
git clone https://github.com/vim/vim
cd vim
git pull && git fetch

#In case Vim was already installed
cd src
make distclean
cd ..

py2configdir=$(find /usr/lib/python2* -name python.o | cut -f1,2,3,4,5 -d/)
py3configdir=$(find /usr/lib/python3* -name python.o | cut -f1,2,3,4,5 -d/)

./configure \
  --with-features=huge \
  --enable-multibyte \
  --enable-perlinterp=dynamic \
  --enable-rubyinterp=dynamic \
  --with-ruby-command=ruby \
  --enable-pythoninterp=dynamic \
  --with-python-config-dir=$py2configdir \
  --enable-python3interp \
  --with-python3-config-dir=$py3configdir \
  --enable-luainterp \
  --with-luajit \
  --enable-cscope \
  --enable-gui=auto \
  --with-x \
  --enable-fontset \
  --enable-largefile \
  --disable-netbeans \
  --with-compiledby="Demian Molinari" \
  --enable-fail-if-missing \

# compile
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81

# install
sudo checkinstall

# set as default editor
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

# output correct install
vim --version

# instal ripgrep
cd ~/
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.9.0/ripgrep_0.9.0_amd64.deb
sudo dpkg -i ripgrep_0.9.0_amd64.deb
rm ripgrep_0.9.0_amd64.deb

# install other console software which is nice:
sudo apt install cmake dkms dos2unix ffmpeg fortune unzip unrar ranger

# Instalar ctags
sudo apt install automake autoconf autotools-dev
cd ~/
git clone https://github.com/universal-ctags/ctags
cd ctags
./autogen.sh
./configure
make
sudo make install
cd ..
rm -rf ctags/

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
