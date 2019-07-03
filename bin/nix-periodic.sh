#!/usr/bin/env bash

set -x -e

sudo nix-collect-garbage -d --delete-older-than 14d
sudo fstrim -v -a
sudo nix-channel --update nixos
sudo nix-channel --update nixos-unstable
nix build --no-link -f '<nixpkgs/nixos>' config.system.build.toplevel
sudo nixos-rebuild switch

nix-env -u

pushd ~/.xmonad
./build --rebuild aaa
popd

