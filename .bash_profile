#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
setxkbmap es

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
