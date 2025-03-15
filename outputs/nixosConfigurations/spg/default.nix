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

  gm = {
    programs.hyprland.enable = true;
  };

  users = {
    mutableUsers = false;
    users = {
      codman = {
        initialPassword = "password";
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        packages = with pkgs; [
          tree
          git
        ];
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      pciutils
      usbutils
    ];
    variables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };
  };

  services.getty.autologinUser = "codman";

  programs.neovim.enable = true;

  imports = [
    inputs.ff.nixosModules.freedpomFlake
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix
    ./hyprland.nix
    # ./getty.nix
  ];
}
