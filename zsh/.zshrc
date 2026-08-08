export PATH=$HOME/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

# Ensure terminal colors work inside tmux
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

# Make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=5

# Ctrl+space accepts the auto-suggestion
bindkey '^ ' autosuggest-accept

# copy current input on command-prompt to clipboard:
copy-prompt-to-clipboard() {
  zle kill-buffer
  print -rn -- "$CUTBUFFER" | pbcopy
}

zle -N copy-prompt-to-clipboard
bindkey -M viins '^]' copy-prompt-to-clipboard

# Disable that annoying beep.
unsetopt BEEP

if [[ $(command -v "carapace") ]]; then
  # export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
  zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  source <(carapace _carapace)
fi
