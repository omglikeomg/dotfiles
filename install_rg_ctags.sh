#!/bin/bash

# install ripgrep
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
