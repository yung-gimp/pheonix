{
  inputs,
  self,
  pkgs,
  ...
}: {
  ff = {
    common.enable = true;

    services = {
      ananicy.enable = true;
      virt-reality = {
        enable = true;
        autoStart = true;
      };

      consoles = {
        enable = true;
        getty = ["codman@tty1"];
        kmscon = ["tty2"];
      };
      # pipewire.enable = true;
    };

    system = {
      fontsu.enable = true;
      nix.enable = true;
      performance.enable = true;
      systemd-boot.enable = true;
      preservation = {
        enable = true;
        preserveHome = true;
      };
    };

    userConfig = {
      users = {
        codman = {
          uid = 1000;
          role = "admin";
          tags = ["base"];
          hashedPassword = "$6$i8pqqPIplhh3zxt1$bUH178Go8y5y6HeWKIlyjMUklE2x/8Vy9d3KiCD1WN61EtHlrpWrGJxphqu7kB6AERg6sphGLonDeJvS/WC730";
        };
      };
    };
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
  };

  home-manager.users.codman = {
    home.stateVersion = "25.05";
    imports = [
      self.homeModules.codmod
      inputs.ff.homeModules.freedpomFlake
    ];

    ff.programs.bash.enable = true;

    cm = {
      hyprland.enable = true;
      programs = {
        firefox.enable = true;
        librewolf.enable = true;
        git.enable = true;
        media.enable = true;
        nvf.enable = true;
      };
    };
  };

  #age.rekey.agePlugins = [pkgs.age-plugin-fido2-hmac];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  services.tailscale.enable = true;
  systemd.tmpfiles.rules = [
    "d /home/codman 0750 codman users" #should maybe add to preservation
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };

  fileSystems."/home/codman/games" = {
    depends = ["/nix/persist/games"];
    device = "/nix/persist/games";
    fsType = "none";
    options = ["bind"];
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };
  system.stateVersion = "25.05";

  imports = [
    inputs.disko.nixosModules.disko
    ./audio.nix
    ./programs
    ./disko.nix
    ./hardware.nix
  ];
}
