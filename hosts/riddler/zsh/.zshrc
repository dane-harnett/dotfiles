if [ -d "$HOME/bin" ] ; then
  export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi
export XDG_CONFIG_HOME=$HOME/.config

if [ -d "$HOME/.antidote" ]; then
  source "$HOME/.antidote/antidote.zsh"
  antidote load
fi

# Ensure terminal colors work inside tmux
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

# Make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Set keybinds to vi mappings
bindkey -v
# Ctrl+space accepts the auto-suggestion
bindkey '^ ' autosuggest-accept

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Disable that annoying beep.
unsetopt BEEP

if [[ $(command -v "oh-my-posh") ]]; then
  source <(fzf --zsh)
fi

if [[ $(command -v "oh-my-posh") ]]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/default.toml)"
fi

# aliases

alias ll="ls -lah"

if [[ $(command -v "eza") ]]; then
  alias ls="eza"
fi

if [[ $(command -v "zoxide") ]]; then
  eval "$(zoxide init zsh)"
  alias cd="z"
  alias zz="z -"
fi
