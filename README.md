# dotfiles
Welcome to my dotfiles repository. This is where I keep the configuration
for my personal computer setup.
I use or have used the following software:

## Package management
brew

## Configuration management
I use `stow` to install the configuration from this repository into my home directory.

## Terminal emulator
I currently use wezterm but have used alacritty and iterm2 in the past.

## Terminal multiplexer
I use tmux. tmux is a terminal multiplexer: it enables a number of terminals to be created, accessed, and controlled from a single screen.

## Shell environment
zsh is my preferred shell environment. I use the antidote plugin manager for zsh.

## Text editor
I use neovim.

## Command palette
I use raycast with some custom scripts.

## Shell utilities

### eza
A better `ls`

### fzf
A fuzzy-finder.

### zoxide
A better `cd`

### gnu-sed
Used for text replacement in nvim-spectre

## Node.js version management
I use both Fast Node Manager (`fnm`) and Node Version Manager (`nvm`) (for reasons).

# Install
Clone this repository somewhere on the machine you want to be configured.

Run the `./setup-install` script to install all the required software.
Run the `./install` script to apply the configuration.

# Uninstall
Run the `./uninstall` script to remove the configuration.

