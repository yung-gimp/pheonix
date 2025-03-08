{ inputs, lib, ...}:
{

  ff = {

    system = {
      systemd-boot.enable = true;
    };
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "24.11";

  imports = [
    inputs.ff.nixosModules.freedpomFlake
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
  ];
}
