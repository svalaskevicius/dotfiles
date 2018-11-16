#!/usr/bin/env bash

set -x -e

sudo nix-collect-garbage -d --delete-older-than 14d
sudo nix-channel --update nixos
sudo nix-channel --update nixos-unstable
sudo nixos-rebuild switch --upgrade
nix-env -u
