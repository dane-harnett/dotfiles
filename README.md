# dotfiles

Welcome to my dotfiles repository. This is where I keep the configuration
for my personal computer setup.

## How to setup computer to use nix+nix-darwin

### Install nix

```bash
sh <(curl -L https://nixos.org/nix/install)
```

### Command to initialise a new flake

```bash
nix flake init -t nix-darwin --extra-experimental-features "nix-command flakes"
```

### Ensure nix symlink

`~/.config/nix` should be symlinked to `nix/.config/nix` in this project

### First time building flake

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake "$(readlink -f ~/.config/nix)#personal-m4mbp"
```

### Updating flake

This updates the inputs so the next time the flake is rebuilt it will install the most up to date packages.

```bash
cd nix/.config/nix
nix flake update
cd ../../..
```

### Rebuilding flake

```bash
sudo darwin-rebuild switch --flake "$(readlink -f ~/.config/nix)#personal-m4mbp"
```

## Applications that are configured in this repository

### Terminal emulator

I currently use wezterm but have used alacritty and iterm2 in the past.

### Terminal multiplexer

I use tmux. tmux is a terminal multiplexer: it enables a number of terminals to be created, accessed, and controlled from a single screen.

### Shell environment

zsh is my preferred shell environment. I use the antidote plugin manager for zsh.

### Text editor

I use neovim.

### Shell utilities

#### eza

A better `ls`

#### fzf

A fuzzy-finder.

#### zoxide

A better `cd`

#### gnu-sed

Used for text replacement in nvim-spectre

### Node.js version management

I use Fast Node Manager (`fnm`)
