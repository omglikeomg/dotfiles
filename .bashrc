#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set 256 color xterm if possible
if [ -n "$DISPLAY" ]; then
  export TERM=xterm-256color
fi

localectl set-keymap --no-convert es
export VISUAL=vim
export EDITOR="$VISUAL"
export PATH=$PATH:/usr/local/go/bin/
export PATH=$PATH:~/bin/
export GOPATH="$HOME/golang"
export GOBIN="$GOPATH/bin"
export GOPATH=$GOPATH:"$HOME/exercism/go/"

alias python3='python3.7'
# If id command returns zero, youve root access.
if [ $(id -u) -eq 0 ];
then # root has red color prompt
  export PS1="\[\e[34m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[34m\]]\[\e[m\]-(\[\e[33m\]\W\[\e[m\])-:\n\\$ "
else # regular
  PS1="┌─[\`if [ \$? = 0 ]; then echo \[\e[32m\]✔\[\e[0m\]; else echo \[\e[31m\]✘\[\e[0m\]; fi\`]───[\[\e[01;49;39m\]\u\[\e[00m\]\[\e[01;49;39m\]@\H\[\e[00m\]]───[\[\e[1;49;34m\]\W\[\e[0m\]]───[\[\e[1;49;39m\]\$(ls | wc -l) files, \$(ls -lah | grep -m 1 total | sed 's/total //')\[\e[0m\]]\n└───▶ "
fi

# i hate cd-ing..
alias ..="cd .."
alias ...="cd ..; cd .."
alias ....="cd ..; cd ..; cd .."
alias .....="cd ..; cd ..; cd ..; cd .."
# diskspace utilities
alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias diskspace="du -S | sort -n -r |more"

alias frak="fortune"
#set vi mode if possible
set -o vi
clear

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
