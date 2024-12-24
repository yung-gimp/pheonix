{ pkgs, ... }: 

{
    home.stateVersion = "24.05";
    home.username = "codman";
    home.homeDirectory = "/home/codman";
    programs.home-manager.enable = true;
    home.packages = [ pkgs.htop ];
}
