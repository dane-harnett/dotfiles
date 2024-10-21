export PATH=$HOME/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

# source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
# antidote load

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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/config.json)"


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
