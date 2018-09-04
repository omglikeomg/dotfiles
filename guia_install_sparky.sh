# Sparky Linux

# Instalación

# --> sudo sparkylinux-installer

# configurar locales, teclado, particiones, etc

# se instala (tarda un rato)

# seleccionar i3wm
# seleccionar firefox

# instalar git
sudo apt install git

# instalar dependencias de i3
sudo apt-get install i3status dmenu i3lock xbacklight feh

# instalar dependencias de vim (dejar fuera lo que haga falta):
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git

# https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
      --enable-rubyinterp=yes \
      --enable-pythoninterp=yes \
      --with-python-config-dir=/usr/lib/python2.7/config \ # pay attention here check directory correct
      --enable-python3interp=yes \
      --with-python3-config-dir=/usr/lib/python3.5/config \
      --enable-perlinterp=yes \
      --enable-luainterp=yes \
            --enable-gui=gtk2 \ # maybe not...
            --enable-cscope \
     --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
# para desinstalar vim en un futuro...
sudo apt install checkinstall
cd ~/vim
sudo checkinstall

# Definir variables de sistema, entre ellas: el editor por defecto:
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

# Cambiar el terminal a uxterm
sudo update-alternatives --config x-terminal-emulator

# Instalar curl!
# mkdir siempre tendría que ser -p (parents)
alias mkdir="mkdir -p"
