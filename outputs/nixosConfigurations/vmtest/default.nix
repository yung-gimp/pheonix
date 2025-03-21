{
  inputs,
  lib,
  ...
}:
{

  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  ff = {
    system = {
      nix.enable = true;
      systemd-boot.enable = true;
      persistence.enable = false;
    };
    services.kmscon = {
      enable = true;
      disableAt = [
        "tty1"
      ];
    };
    common.enable = true;
    userConfig = {
      users = {
        codman = {
          uid = 1000;
          extraGroups = [ "wheel" ];
        };
      };
    };
  };

  # users = {
  #   mutableUsers = false;
  #   users = {
  #     codman = {
  #       initialPassword = "password";
  #       isNormalUser = true;
  #       extraGroups = [ "wheel" ];
  #       packages = with pkgs; [
  #         tree
  #       ];
  #     };
  #   };
  # };

  fileSystems."/etc/nixos" = {
    device = "viofs";
    fsType = "virtiofs";
    options = [ "nofail" ];
  };

  imports = [
    inputs.ff.nixosModules.freedpomFlake
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
    ./userConfig.nix
  ];
}
