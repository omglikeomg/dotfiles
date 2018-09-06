#!/bin/bash

# i3 WINDOW MANAGER EXTRAS
##########################
sudo apt install i3status dmenu i3lock xbacklight feh

# VIM
#####
# ubuntu distro
sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
 
# Everything needed for compiling + git + curl
 sudo apt-get install liblua5.1-dev \
   luajit libluajit-5.1 python-dev ruby-dev libperl-dev \
   libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev \
   libxt-dev python3-dev curl git

py2=$(whereis python | awk '{print $2}')
py3=$(whereis python3 | awk '{print $2}')
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
  --with-python-config-dir=$py2 \
  --enable-python3interp \
  --with-python3-config-dir=$py3 \
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
  --enable-fail-if-missing \
  --with-x

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

# install ripgrep
cd ~/
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.9.0/ripgrep_0.9.0_amd64.deb
sudo dpkg -i ripgrep_0.9.0_amd64.deb
rm ripgrep_0.9.0_amd64.deb

# install other console software which is nice:
sudo apt install cmake dkms dos2unix ffmpeg fortune lxsplit unzip unrar ranger

# CONFIGS:
##########

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
fc-cache -fv
# ahora sí
cd ~
git clone https://github.com/omglikeomg/bitmap-fonts.git
cd bitmap-fonts
mkfontdir bitmap/
sudo cp -avr bitmap/ /usr/share/fonts
xset fp+ ~/.local/share/fonts/bitmap # esto puede ser innecesario
fc-cache -fv

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

# Copiar los dotfiles incluidos
cd ~/
cd dotfiles
cp .bashrc ~/
cp -dru .config/ ~/
cp .Xresources ~/
cp .vimrc ~/
cp vimtips.txt ~/.vim
# Runs Vim and installs plugin manager so you can check everything's in order
vim -c "InstallPlug | :q!"

# install more useful software
sudo apt install cmus transmission transmission-cli vlc id3v2 shutter scrot
# youtube-dl
curl -L https://yt-dl.org/latest/youtube-dl -o /usr/bin/youtube-dl
sudo chmod 755 /usr/bin/youtube-dl
