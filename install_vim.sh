#!/bin/bash

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
