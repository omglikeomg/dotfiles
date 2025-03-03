Dotfiles for easy scaffolding in new PCs

## Prerequisites
- GNU Stow
- Make
- Git

For MacOS, you will want to install Brew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```


## Installation
Execute the installation script:
```
./installation_script.sh --os <os>  # os can be debian or macos
```
**NOTE**: I'm only supporting Debian & MacOS for now. Not sure if will be adding support for other distros/package managers in the future.
It is actually more likely I will add scaffolding for windows systems.

Then, you can install all the dotfiles with:
```bash
make all
```

Some configs might not be useful for every system:
- Xresources, xsessionrc ...
- rofi config
Even myself I'm not using them since I moved away from Bunsenlabs

To Install Go, follow [these instructions](https://medium.com/@unlair/setting-up-golang-on-linux-the-right-way-c546b212dd48)

# TODO:
- Add explanation for linux config files such as xsession, xresources
- Consider adding a specific vim documentation file. Include coc.nvim as it's not going anywhere it seems.
- Maybe manage .vim and .vimrc in a more granular fashion (
- Add chocolatey + powershell integrations for windows

## Future improvements?
Just some stuff I might want to try sometime
- [bat as a replacement for cat](https://github.com/sharkdp/bat)
- [dust as a replacement for du](https://github.com/bootandy/dust)
- [btop > htop > top](https://github.com/aristocratos/btop)
- [atuin to manage history](https://github.com/atuinsh/atuin)
- [yazi as file manager (more like ranger than mc)](https://github.com/sxyazi/yazi)
