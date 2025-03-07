{ lib, inputs, ... }:
{

  imports = [
    inputs.ff.nixosModules.freedpomFlake
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  ff.system.systemd-boot.enable = true;

}
