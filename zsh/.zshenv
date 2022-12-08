export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=$HOME/.deno/bin:$PATH
export PATH=$HOME/projects/utils/lua-language-server/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

# Ensure terminal colors work inside tmux
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

# Set the directory where nvm should be
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

# Make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Conditionally prepare environment variables for cargo/rust
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# Conditionally add cabal and .ghcup to the path for haskell
if [ -f "$HOME/.ghcup/env" ]; then
  source "$HOME/.ghcup/env" # ghcup-env
fi

# Conditionally add ruby to the path
if which ruby >/dev/null && which gem >/dev/null; then
  PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
