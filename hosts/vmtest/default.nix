{ lib, inputs, ... }:
{

  imports = [
    inputs.ff.nixosModules.freedpomFlake
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "24.11"; # Funny Compatibility field

  ff.system.systemd-boot.enable = true;
  ff.common.enable = true;

}
