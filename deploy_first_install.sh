#!/bin/bash

# ubuntu distro
sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
 
# instalar las versiones más recientes de estos paquetes
# sudo apt-get install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev

#Optional: so vim can be uninstalled again via `dpkg -r vim`
sudo apt-get install checkinstall

sudo rm -rf /usr/local/share/vim /usr/bin/vim

cd ~
git clone https://github.com/vim/vim
cd vim
git pull && git fetch

#In case Vim was already installed
cd src
make distclean
cd ..

./configure \
  --enable-multibyte \
  --enable-perlinterp=dynamic \
  --enable-rubyinterp=dynamic \
  --with-ruby-command=RUBY_DIR_GOES_HERE \
  --enable-pythoninterp=dynamic \
  --with-python-config-dir=PYTHON_2_DIR_GOES_HERE \
  --enable-python3interp \
  --with-python3-config-dir=PYTHON_DIR_GOES_HERE \
  --enable-luainterp \
  --with-luajit \
  --enable-cscope \
  --enable-gui=auto \
  --with-features=huge \
  --with-x \
  --enable-fontset \
  --enable-largefile \
  --disable-netbeans \
  --with-compiledby="Demian Molinari" \
  --enable-fail-if-missing

make && sudo make install
