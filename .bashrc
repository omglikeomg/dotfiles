# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source ~/terminal_scripts/common_shell_setup

# prompt
if [ -f ~/terminal_scripts/bash_prompt ]; then
  source ~/terminal_scripts/bash_prompt
fi

# my aliases
if [ -f ~/terminal_scripts/bash_aliases ]; then
  source ~/terminal_scripts/bash_aliases
fi

# drupal-related aliases
if [ -f ~/terminal_scripts/drupal_related ]; then
  source ~/terminal_scripts/drupal_related
fi

# ssh-keys?
if [ -f ~/.ssh/ssh_keys ]; then
  source ~/.ssh/ssh_keys
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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
