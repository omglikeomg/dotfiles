# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=500000
HISTFILESIZE=800000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

alias ll='ls -Galh'
alias la='ls -GA'
alias l='ls -GCF'
alias vi='hx'
alias f='find . -iregex'

# php code sniffer for drupal
# alias drupalcs="php ~/Descargas/PHP_CodeSniffer-3.5.8/bin/phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"
# alias drupalcsp="php ~/Descargas/PHP_CodeSniffer-3.5.8/bin/phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"
# alias drupalcbf="php ~/Descargas/PHP_CodeSniffer-3.5.8/bin/phpcbf --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"

export EDITOR=vim
source ~/git-completion.zsh
source ~/.git-prompt.sh
# if [ $(id -u) -eq 0 ];
# then # root has red color prompt
# export PS1="\[\e[34m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[34m\]]\[\e[m\]-(\[\e[33m\]\W\[\e[m\])-:\n\\$ "
# else # regular
# PS1='\n┌──[\[\e[01;49;39m\]\u\[\e[00m\]\[\e[01;49;39m\]@\H\[\e[00m\]]───[\[\e[1;49;34m\]\w\[\e[0m\]]───[\[\033[01;32m\]$(__git_ps1 "%s")\[\033[00m\]]\n└───[$] '
# fi
setopt PROMPT_SUBST
PROMPT=$'\n┌──[%F{10}%n@%M%f]───[%F{12}%0~%f]───[%F{11}$(__git_ps1 "%s")%f]\n└───[$] '
RPROMPT="[%F{111}%D{%f/%m/%y} %@%f]"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_OPTS="--preview 'head -$LINES {}'"
[ -f ~/.fzf_functions_common ] && source ~/.fzf_functions_common

# i hate cd-ing..
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# ALIASES FOR LANDO
alias lando-ww='lando drush -l weddingwire.com'
alias lando-tk='lando drush -l theknot.com.paper'
alias mysql-start='mysql.server start --sql-mode=""'

if [ -f ~/add-ssh-keys ]; then
    source ~/add-ssh-keys
fi
# AVOID PROBLEMS WITH CTRL-S ON TERMINAL AND VIM INPUT
stty -ixon
# Change iterm2 profile. Usage it2prof ProfileName (case sensitive)
it2prof() { echo -e "\033]50;SetProfile=$1\a" }

export PATH="$PATH:$HOME/.composer/vendor/bin"

clear


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export JENKINS_SECRET="114e1d1037d69fefe2adda12bb0bd50bd7"
export JENKINS_USERNAME="dmolinari@bodas.net"
export JENKINS_URL="https://pipelines.eng.theknotww.com"


# FOR USING GITHUB REPOS W/PERMISSIONS
export NPM_TOKEN=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

alias drupalcs='phpcs --standard=Drupal -n --extensions=php,module,inc,install,test,profile,theme,info,scss,txt,md --ignore="*.css,node_modules"'
alias drupalfix='phpcbf --standard=Drupal -n --extensions=php,module,inc,install,test,profile,theme,info,scss,txt,md --ignore="*.css,node_modules"'

alias ytdl-playlist='yt-dlp --extract-audio --audio-format mp3 -o "%(playlist_autonumber)s. %(title)s.%(ext)s"'
alias ytdl-split-chapters='yt-dlp --extract-audio --audio-format mp3 --split-chapters -o "chapter:%(section_number)s. %(section_title)s.%(ext)s"'
alias rename-trailing-zeroes='rename -e "s;^(\d)\.;0\$1;" *'
