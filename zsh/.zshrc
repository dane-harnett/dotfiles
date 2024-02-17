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

# Disable that annoying beep.
unsetopt BEEP

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
if [[ $(command -v "pyenv") ]]; then
  eval "$(pyenv init -)"
fi

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# Custom p10k prompt for git repository info
# uses git-status-fly for improved performance in large repositories.
function prompt_my_gsf() {
  # The git-status-fly binary will run git status and output a script that
  # will set environment variables with the git information.
  . <(git-status-fly)
    local res=""
    local state='CLEAN'
    local background="${POWERLEVEL9K_VCS_CLEAN_BACKGROUND}"
    local myGsfIcon=$'\uF1D2'

    if [[ -n $GSF_REPOSITORY && "$GSF_REPOSITORY"=="1" ]]; then

      if [[ -n $GSF_BRANCH ]]; then
        local branch=${GSF_BRANCH}
        # If local branch name is at most 32 characters long, show it in full.
        # Otherwise show the first 12 … the last 12.
        # Tip: To always show local branch name in full without truncation, delete the next line.
        (( $#branch > 32 )) && branch[13,-13]="…"  # <-- this line
        res+="${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}"
      fi

      if [[ -n $GSF_STASH && "$GSF_STASH"=="1" ]]; then
        res+=" *"
      fi
      if [[ -n $GSF_DIRTY && "$GSF_DIRTY"=="1" ]]; then
        state='MODIFIED'
        background="${POWERLEVEL9K_VCS_MODIFIED_BACKGROUND}"
        res+=" !"
      fi
      if [[ -n $GSF_STAGED && "${GSF_STAGED}"=="1" ]]; then
        state='MODIFIED'
        background="${POWERLEVEL9K_VCS_MODIFIED_BACKGROUND}"
        res+=" +"
      fi

      p10k segment -s ${state} -b "${background}" -i "${myGsfIcon}" -t "${res}"
    fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# If git-status-fly is available then use it to power the git prompt segment,
# otherwise fallback to the p10k vcs segment.
if [[ $(command -v "git-status-fly") ]]; then
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=my_gsf
else
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=vcs
fi

