# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  per-directory-history
  zsh-autosuggestions
)

# Initialize oh-my-zsh
source $ZSH/oh-my-zsh.sh

# My custom configuration

# Set keybinds to vi mappings
bindkey -v
# Ctrl+space accepts the auto-suggestion
bindkey '^ ' autosuggest-accept

# If my personal github ssh key exists then configure ssh-agent to use it
if [ -f "$HOME/.ssh/github" ]; then
  ssh-agent | source /dev/stdin > /dev/null
  ssh-add -q --apple-use-keychain ~/.ssh/github
fi

# Initialize nvm if it's installed
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"

  # Whenever changing directory... get nvm to check the current directory for
  # an nvmrc file and switch to the appropriate node version automatically.
  autoload -U add-zsh-hook
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
  # Load nvm bash completion
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
fi

# Initialize starship if it's installed
[[ $(command -v "starship") ]] && eval "$(starship init zsh)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
