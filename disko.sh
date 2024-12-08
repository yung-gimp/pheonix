#!/bin/bash

sudo nix --experimental-features "flakes nix-command" run 'github:nix-community/disko/latest#disko-install' -- --show-trace --write-efi-boot-entries --flake "/tmp/config/etc/nixos#${1}" --disk 'nix' "/dev/${2}" --disk 'home' "/dev/${3}"
