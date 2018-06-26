#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

loadkeys es
export VISUAL=vim
export EDITOR="$VISUAL"
alias ls='ls -GH'
alias ll='ls -lGH'
alias v='vim --remote-silent'
alias g='gvim --remote-silent'

# If id command returns zero, youve root access.
if [ $(id -u) -eq 0 ];
then # root has red color prompt
  PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
else # regular
  PS1="---\e[0;35m[\u@\h]\e[m---\e[0;33m[\w]\e[m---\n\$"
fi


clear


archey3
