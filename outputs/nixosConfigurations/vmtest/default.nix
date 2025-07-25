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
      fontsu.enable = true;
      persistence = {
        enable = true;
        ephHome = true;
      };
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
          role = "admin";
          tags = [ "base" ];
          hashedPassword = "$6$i8pqqPIplhh3zxt1$bUH178Go8y5y6HeWKIlyjMUklE2x/8Vy9d3KiCD1WN61EtHlrpWrGJxphqu7kB6AERg6sphGLonDeJvS/WC730";
          homeModule = inputs.cm.homeModules.codmod;
        };
      };
    };
  };

  fileSystems."/etc/nixos" = {
    device = "viofs";
    fsType = "virtiofs";
    options = [ "nofail" ];
  };

  services.scx.enable = lib.mkForce false;

  imports = [
    inputs.ff.nixosModules.freedpomFlake
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
  ];
}
