export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=$HOME/.deno/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

# Ensure terminal colors work inside tmux
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

# Make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Conditionally prepare environment variables for cargo/rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Conditionally add cabal and .ghcup to the path for haskell
[[ -f "$HOME/.ghcup/env" ]] && source "$HOME/.ghcup/env"

# My custom configuration

# Ctrl+space accepts the auto-suggestion
bindkey '^ ' autosuggest-accept

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# copy current input on command-prompt to clipboard:
copy-prompt-to-clipboard() {
  zle kill-buffer
  print -rn -- "$CUTBUFFER" | pbcopy
}

zle -N copy-prompt-to-clipboard
bindkey -M viins '^]' copy-prompt-to-clipboard

# If my personal github ssh key exists then configure ssh-agent to use it
if [ -f "$HOME/.ssh/github" ]; then
  ssh-agent | source /dev/stdin > /dev/null
  ssh-add -q --apple-use-keychain ~/.ssh/github
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

# Disable that annoying beep.
unsetopt BEEP

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
if [[ $(command -v "pyenv") ]]; then
  eval "$(pyenv init -)"
fi

if [[ $(command -v "carapace") ]]; then
  # export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
  zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  source <(carapace _carapace)
fi

