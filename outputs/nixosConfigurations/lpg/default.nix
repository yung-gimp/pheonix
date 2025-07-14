{ inputs, ... }:

{
  ff = {
    common.enable = true;

    services = {
      ananicy.enable = true;
      kmscon = {
        enable = true;
        disableAt = [
          "tty1"
        ];
      };
      pipewire.enable = true;
    };

    system = {
      fontsu.enable = true;
      nix.enable = true;
      performance.enable = true;
      systemd-boot.enable = true;
      persistence = {
        enable = true;
        ephHome = true;
      };
    };

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

  home-manager.users.codman = {
    cm = {
      programs = {
        firefox.enable = true;
        git.enable = true;
        media.enable = true;
        nvf.enable = true;
      };
    };
  };

  systemd.tmpfiles.rules = [ "d /nix/persist/games 0750 codman users" ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };
  system.stateVersion = "25.05";

  imports = [
    inputs.ff.nixosModules.freedpomFlake
    inputs.disko.nixosModules.disko
    ./programs
    ./disko.nix
    ./hardware.nix
  ];
}
