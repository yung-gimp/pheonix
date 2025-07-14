{ pkgs, inputs, ... }:
{
  home = {
    packages = [
      pkgs.htop
    ];
    stateVersion = "24.11";
  };

  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    inputs.nvf.homeManagerModules.default
    ./hyprland
    ./persist.nix
    ./programs
  ];
}
