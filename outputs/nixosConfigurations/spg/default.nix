{
  inputs,
  lib,
  pkgs,
  ...
}:
{

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "24.11";

  ff = {
    system = {
      nix.enable = true;
      systemd-boot.enable = true;
      persistence.enable = true;
    };
    common.enable = true;
  };

  users = {
    mutableUsers = false;
    users = {
      codman = {
        initialPassword = "password";
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
          tree
          git
        ];
      };
    };
  };

  programs.neovim.enable = true;

  imports = [
    inputs.ff.nixosModules.freedpomFlake
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
    ./kmscon.nix
  ];
}
