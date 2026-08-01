#!/bin/zsh

set -e

cd "${0:A:h}/.."
sudo darwin-rebuild switch --flake "$(readlink -f "$HOME/.config/nix")#personal-m4mbp"
