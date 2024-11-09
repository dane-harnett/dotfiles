# Nix configuration

## Usage

Install nix and nix darwin
TODO: document these commands

## How to apply configuration

Run `darwin-rebuild switch --flake "$(readlink -f ~/.config/nix)#personal-i9mbp"`

## How to update

From repo root: `cd nix/.config/nix`
Run `nix flake update`
