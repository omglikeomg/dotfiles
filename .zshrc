# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source ~/terminal_scripts/common_shell_setup

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# git_ps1
if [ ! -f ~/.git-prompt.sh ]; then
  curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi

# prompt
if [ -f ~/terminal_scripts/zsh_prompt ]; then
  source ~/.git-prompt.sh
  source ~/terminal_scripts/zsh_prompt
fi

# my aliases
if [ -f ~/terminal_scripts/my_aliases ]; then
  source ~/terminal_scripts/my_aliases
fi

# drupal-related aliases
if [ -f ~/terminal_scripts/drupal_related ]; then
  source ~/terminal_scripts/drupal_related
fi


# iterm2 stuff
if [ -f ~/terminal_scripts/iterm2 ]; then
  source ~/terminal_scripts/iterm2
fi

# utils-related stuff
if [ -f ~/terminal_scripts/other_software ]; then
  source ~/terminal_scripts/other_software
fi

# work-stuff
if [ -f ~/work_variables ]; then
  source ~/work_variables
fi
# ssh-keys?
if [ -f ~/.ssh/ssh_keys ]; then
  source ~/.ssh/ssh_keys
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# download completion from: https://github.com/chrisands/zsh-yarn-completions
if [ -f ~/.zsh-yarn-completions/zsh-yarn-completions.plugin.zsh ]; then 
  source ~/.zsh-yarn-completions/zsh-yarn-completions.plugin.zsh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
