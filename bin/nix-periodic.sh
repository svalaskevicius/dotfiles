#!/usr/bin/env bash

set -x -e

sudo nix-collect-garbage -d --delete-older-than 14d
sudo fstrim -v -a
sudo nix-channel --update nixos
sudo nix-channel --update nixos-unstable
sudo nixos-rebuild switch --upgrade
nix-env -u

pushd ~/.xmonad
./build --rebuild aaa
popd

