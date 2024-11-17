{ config, pkgs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.username = "codman";
  home.homeDirectory = "/home/codman";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
 
  home.persistence."/nix/persist/home/codman" = {
    directories = [
    "Documents"
    "Downloads"
    ];
    files = [
 
    ];
    allowOther = true;
  };
}
