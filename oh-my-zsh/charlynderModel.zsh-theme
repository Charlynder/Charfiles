# Charlynder Model theme for zsh
# A theme that changes based on different modes

# Environment variables
# Set the "toons" for different environments
function pythonsnake {
    echo -n "🐍"
}

function tmuxbolt {
    echo -n "⚡️"
}

function cancer {
    echo -n "♋︎"
}

# Initialize vcs_info for git branch display
autoload -Uz vcs_info
setopt prompt_subst

# Configure vcs_info styles
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{yellow}+'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%c%u%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}[%F{2}%b%c%u%F{5}]%f '
zstyle ':vcs_info:svn:*' branchformat '%b'
zstyle ':vcs_info:svn:*' actionformats '%F{5}[%F{2}%b%F{1}:%F{3}%i%F{3}|%F{1}%a%c%u%F{5}]%f '
zstyle ':vcs_info:svn:*' formats '%F{5}[%F{2}%b%F{1}:%F{3}%i%c%u%F{5}]%f '
zstyle ':vcs_info:*' enable git cvs svn

# Functions to detect if we're in tmux or python 
function in_tmux {
    [[ -n "$TMUX" ]]
}

function in_python_venv {
    [[ -n "$VIRTUAL_ENV" ]]
}

# Function to build the appropriate prompt
function build_prompt {
    local prompt_str=""
    
    if in_python_venv; then
        prompt_str="$(pythonsnake) [%B%F{11}$(basename "$VIRTUAL_ENV")%f%b: %~] %{$reset_color%}${vcs_info_msg_0_}%{$reset_color%}» "
    elif in_tmux; then 
        prompt_str="$(tmuxbolt) [%F{cyan}%n%f:%F{blue}%c%f] %{$reset_color%}${vcs_info_msg_0_}%{$reset_color%} ~ "
    else
        prompt_str="$(cancer)[%F{050}%n%f: %~] %{$reset_color%}${vcs_info_msg_0_}%{$reset_color%}» "
    fi
    
    echo -n "$prompt_str"
}

# Function to update vcs_info and rebuild prompt before each command
function theme_precmd {
    vcs_info
}

# Set up the prompt with dynamic detection
PROMPT='$(build_prompt)'

# Add the precmd hook to update git info automatically
autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd
