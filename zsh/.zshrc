export PATH=$HOME/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

# Ensure terminal colors work inside tmux
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

# Make vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

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

# Disable that annoying beep.
unsetopt BEEP

if [[ $(command -v "carapace") ]]; then
  # export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
  zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  source <(carapace _carapace)
fi

