# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=$HOME/.deno/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
antidote load
autoload -Uz promptinit && promptinit && prompt powerlevel10k

# Ensure terminal colors work inside tmux
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

# Make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Conditionally prepare environment variables for cargo/rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Conditionally add cabal and .ghcup to the path for haskell
[[ -f "$HOME/.ghcup/env" ]] && source "$HOME/.ghcup/env"

# My custom configuration

# Set keybinds to vi mappings
bindkey -v
# Ctrl+space accepts the auto-suggestion
bindkey '^ ' autosuggest-accept

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# If my personal github ssh key exists then configure ssh-agent to use it
if [ -f "$HOME/.ssh/github" ]; then
  ssh-agent | source /dev/stdin > /dev/null
  ssh-add -q --apple-use-keychain ~/.ssh/github
fi

# Initialize fast node manager (fnm)
[[ $(command -v "fnm") ]] && eval "$(fnm env --use-on-cd --log-level=quiet)"

# These additions to PATH cannot be in zshenv due to order of execution.
export PATH="$(brew --prefix)/opt/util-linux/sbin:$(brew --prefix)/opt/util-linux/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
if [[ $(command -v "jenv") ]]; then
  function jenv() {
    unset -f jenv
    eval "$(command jenv init -)"
    jenv "$@"
  }
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
