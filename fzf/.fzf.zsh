# Setup fzf
BREW_PREFIX=$(brew --prefix)
# ---------
if [[ ! "$PATH" == *$BREW_PREFIX/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$BREW_PREFIX/opt/fzf/bin"
fi

# Auto-completion
# ---------------
source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"

# Key bindings
# ------------
source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
