{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.codman = { ... }: {
    home.stateVersion = "24.05";
    home.username = "codman";
    home.homeDirectory = "/home/codman";
    programs.home-manager.enable = true;
  };
}
