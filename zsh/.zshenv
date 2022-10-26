export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=$HOME/.deno/bin:$PATH
export PATH=$HOME/projects/utils/lua-language-server/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
