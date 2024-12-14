#!/bin/bash

sudo nix --experimental-features "flakes nix-command" run 'github:nix-community/disko/latest#disko-install' -- --show-trace --write-efi-boot-entries --flake "/tmp/config/etc/nixos#${1}" --disk "home" "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00005" --disk "nix" "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00003"
