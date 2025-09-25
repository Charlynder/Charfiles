# Charlynder zshrc file
#
# date created: 07.18.2022
#
# v0.1.2: 09.08.2025

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="charlynderModel"

# auto-update oh-my-zsh
zstyle ':omz:update' mode auto      # update automatically without asking

# Plugins
plugins=(git fzf-tab zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Source zsh-autosuggestions from Homebrew
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# User configuration

# Run neofetch only once per day
if [[ ! -f /tmp/neofetch_run_$(date +%Y%m%d) ]]; then
    fastfetch
    touch /tmp/neofetch_run_$(date +%Y%m%d)
fi

# Language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Set fzf key bindings and fuzzy completion
source <(fzf --zsh)

# import Zoxide
eval "$(zoxide init zsh)"

# reload tmux
# tmux source-file ~/.config/tmux/tmux.conf

# import aliases
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi
