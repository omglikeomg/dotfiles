#!/bin/bash

# Descargar e instalar fuentes alternativas para la configuración
cd ~
git clone https://github.com/omglikeomg/bitmap-fonts
cd bitmap-fonts
sudo cp -avr bitmap/ /usr/local/share/fonts/
sudo cp -avr truetype/ /usr/local/share/fonts/
mkfontdir /usr/local/share/fonts/truetype
mkfontscale /usr/local/share/fonts/truetype
mkfontdir /usr/local/share/fonts/bitmap
mkfontscale /usr/local/share/fonts/bitmap

# Copiar los dotfiles incluidos
cd ~/
mkdir -p .vim/autoload
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
sudo apt install cmus transmission transmission-cli vlc id3v2 scrot
sudo apt install qutebrowser qutebrowser-qtwebengine

# youtube-dl
sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/bin/youtube-dl
sudo chmod 755 /usr/bin/youtube-dl

# requirement for popcorn-time
sudo apt install libgconf-2-4

# set folders in english
if [[ -f ~/.config/user-dirs.dirs ]]; then
  rm ~/.config/user-dirs.dirs
fi
touch ~/.config/user-dirs.dirs
echo 'XDG_DESKTOP_DIR="$HOME/Desktop"' >> ~/.config/user-dirs.dirs
echo 'XDG_DOWNLOAD_DIR="$HOME/Downloads"' >> ~/.config/user-dirs.dirs
echo 'XDG_TEMPLATES_DIR="$HOME/Templates"' >> ~/.config/user-dirs.dirs
echo 'XDG_PUBLICSHARE_DIR="$HOME/Public"' >> ~/.config/user-dirs.dirs
echo 'XDG_DOCUMENTS_DIR="$HOME/Documents"' >> ~/.config/user-dirs.dirs
echo 'XDG_MUSIC_DIR="$HOME/Music"' >> ~/.config/user-dirs.dirs
echo 'XDG_PICTURES_DIR="$HOME/Pictures"' >> ~/.config/user-dirs.dirs
echo 'XDG_VIDEOS_DIR="$HOME/Videos"' >> ~/.config/user-dirs.dirs

echo 'en_US' > ~/.config/user-dirs.locale

# copy some .desktop entries for the apps already set up (for dmenu)
cd ~/dotfiles

cp -r .local ~/

# get docker
sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-commongit clone https://github.com/berlam/debian-lightdm-webkit-greeter.git greeter
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
           stable"
sudo apt update
sudo apt install docker-ce -y



