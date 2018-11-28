#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set 256 color xterm if possible
if [ -n "$DISPLAY" ]; then
  export TERM=xterm-256color
fi

export VISUAL=vim
export EDITOR="$VISUAL"
export PATH=$PATH:/usr/local/go/bin/
export PATH=$PATH:~/bin/
export GOPATH="$HOME/golang"
export GOBIN="$GOPATH/bin"

# If id command returns zero, youve root access.
if [ $(id -u) -eq 0 ];
then # root has red color prompt
  export PS1="\[\e[34m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[34m\]]\[\e[m\]-(\[\e[33m\]\W\[\e[m\])-:\n\\$ "
else # regular
  PS1="┌─[\`if [ \$? = 0 ]; then echo \[\e[32m\]*\[\e[0m\]; else echo \[\e[31m\]×\[\e[0m\]; fi\`]───[\[\e[01;49;39m\]\u\[\e[00m\]\[\e[01;49;39m\]@\H\[\e[00m\]]───[\[\e[1;49;34m\]\W\[\e[0m\]]───[\[\e[1;49;39m\]\$(ls | wc -l) files, \$(ls -lah | grep -m 1 total | sed 's/total //')\[\e[0m\]]\n└───[$] "
fi

# sources fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# aliases
if [ -e ~/.config/bash/aliases ]; then
  . ~/.config/bash/aliases
fi
# fzf functions
if [ -e ~/.config/bash/.fzf_functions_common ]; then
  . ~/.config/bash/.fzf_functions_common
fi
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_COMMAND="find"
if [ -e /usr/local/bin/rg ]; then
  export FZF_ALT_C_COMMAND="rg --files"
fi

# avoid annoying ctrl-s XOFF
stty -ixon

