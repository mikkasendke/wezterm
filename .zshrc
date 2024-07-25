export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

ZSH_THEME_TERM_TAB_TITLE_IDLE="%~%" # remove 15 char left truncated PWD
# User configuration

unsetopt share_history

alias vi=nvim
alias vim=nvim
export editor=nvim

export WLR_NO_HARDWARE_CURSORS=1

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

alias hist='$(history | cut -c 8- | fzf)'
alias gorun='go run .'

mkproj() {
    if [[ -z $1 ]]; then
        echo "Usage: mkproj <project_name>"
        return 1       
    fi

    mkdir $HOME"/dev/$1" &&
        cd $HOME"/dev/$1" &&
        git init > /dev/null &&
        cd - > /dev/null && 
        echo "Successfully created project \"$1\""
}


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    export XDG_CURRENT_DESKTOP=sway
    exec sway
fi
