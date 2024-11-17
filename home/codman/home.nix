{ config, pkgs, ... }:

{
  home.username = "codman";
  home.homeDirectory = "/home/codman";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
