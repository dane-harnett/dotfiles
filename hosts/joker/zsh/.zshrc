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

# copy current input on command-prompt to clipboard:
copy-prompt-to-clipboard() {
  zle kill-buffer
  print -rn -- "$CUTBUFFER" | pbcopy
}

zle -N copy-prompt-to-clipboard
bindkey -M viins '^]' copy-prompt-to-clipboard

# Disable that annoying beep.
unsetopt BEEP

if [[ $(command -v "fzf") ]]; then
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

# Initialize fast node manager (fnm)
[[ $(command -v "fnm") ]] && eval "$(fnm env --use-on-cd --log-level=quiet)"

# load my nvm to fnm shim
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# These additions to PATH cannot be in zshenv due to order of execution.
# export PATH="$(brew --prefix)/opt/util-linux/sbin:$(brew --prefix)/opt/util-linux/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
if [[ $(command -v "jenv") ]]; then
  function jenv() {
    unset -f jenv
    eval "$(command jenv init -)"
    jenv "$@"
  }
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
if [[ $(command -v "pyenv") ]]; then
  eval "$(pyenv init -)"
fi
