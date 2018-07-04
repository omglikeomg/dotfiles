#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

loadkeys es
export VISUAL=vim
export EDITOR="$VISUAL"
alias vi='vim'
alias ls='ls -GH'
alias ll='ls -alGH'
alias v='vim --remote-silent'
alias g='gvim --remote-silent'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

export FZF_ALT_C_COMMAND="bfs -type d -nohidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--bind J:down,K:up --reverse --ansi --multi'
bind -x '"\C-p": mvim'

# If id command returns zero, youve root access.
if [ $(id -u) -eq 0 ];
then # root has red color prompt
  PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
else # regular
  PS1="---\e[0;35m[\u@\h]\e[m---\e[0;33m[\w]\e[m---\n\$"
fi


clear


archey3
