#!/bin/bash
setup_package_manager() {
  case $1 in
    debian)
      COMMAND="sudo apt"
      ;;
    macos)
      COMMAND="brew"
      ;;
  esac

  alias package_manager="$COMMAND"
}

macOsInstall() {
  package_manager install midnight-commander
  package_manager install macvim
  package_manager install coreutils
  package_manager install coreutils
  package_manager install findutils
  package_manager install gnu-sed
  package_manager install gnu-tar
  package_manager install gnu-which

  echo "Install containerization tools"
  wget https://download.docker.com/mac/stable/Docker.dmg
  sudo hdiutil attach Docker.dmg
  sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
  sudo hdiutil detach /Volumes/Docker
  echo "clean installer"
  rm Docker.dmg
  softwareupdate --install-rosetta

  echo "Install ddev"
  package_manager install ddev/ddev/ddev

  echo "Install python3"
  package_manager install python
  python3 -m ensurepip --default-pip
  python3 -m pip install --upgrade pip

  echo "Install thefuck"
  package_manager install thefuck
}

linuxInstall() {
  # Midnight Commander
  package_manager install mc
  # DOCKER
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
  # Add Docker's official GPG key:
  package_manager update
  package_manager install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  package_manager update
  package_manager install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


  # DDEV
  # Add DDEV’s GPG key to your keyring
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://pkg.ddev.com/apt/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/ddev.gpg > /dev/null
  sudo chmod a+r /etc/apt/keyrings/ddev.gpg

  # Add DDEV releases to your package repository
  sudo sh -c 'echo ""'
  echo "deb [signed-by=/etc/apt/keyrings/ddev.gpg] https://pkg.ddev.com/apt/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list >/dev/null

  # Update package information and install DDEV
  sudo sh -c 'echo ""'
  package_manager update && package_manager install -y ddev

  # One-time initialization of mkcert
  mkcert -install

  # Install python3
  package_manager install python3-dev python3-pip python3-setuptools
  # Install thefuck
  pip3 install thefuck --user
}

install_php() {
  echo "Install PHP"
  package_manager install php
  # install composer
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php --quiet
  echo $?
  echo "clear installer"
  rm composer-setup.php
}

install_node() {
  echo "Install nodejs, nvm, yarn"
  package_manager install node nvm yarn
}

# if --os is passed, then the script will install the tools for the specified OS
OS=`getopts --os`
if [ $OS ]; then
  case $OS in
    debian)
      echo "Installing tools for Debian based systems"
      ;;
    macos)
      echo "Installing tools for MacOS"
      ;;
    *)
      echo "Unsupported OS or None Present. '--os' Flag value: $OS"
      exit 1
      ;;
  esac
fi

setup_package_manager $OS

echo "============================="
echo "| New Installation Scaffold |"
echo "============================="
echo ""
echo "Install git"
package_manager install git
echo ""
echo "Install tools for CLI"
# Basics
package_manager install gawk
package_manager install wget
package_manager install curl
package_manager install htop
package_manager install stow
# QOL tools
package_manager install ripgrep
package_manager install fzf
package_manager install bat
package_manager install vim
# Extras
package_manager install ffmpeg
package_manager install yt-dlp
package_manager install rename

echo ""
echo "Install Node"
# Install node
install_node
# Install Php
echo ""
echo "Install Php"
install_php
# Install OS_specific
case $OS in
  debian)
    linuxInstall
    ;;
  macos)
    macOsInstall
    ;;
esac
