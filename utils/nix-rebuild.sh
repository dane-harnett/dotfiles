#!/bin/zsh

sudo darwin-rebuild switch --flake "$(readlink -f $HOME/.config/nix)#personal-m4mbp"
