#!/bin/zsh

set -e

cd "${0:A:h}/../nix/.config/nix"
nix flake check
