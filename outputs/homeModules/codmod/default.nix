{ pkgs, inputs, ... }:
{
  home = {
    packages = [
      pkgs.htop
    ];
  };

  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    inputs.nvf.homeManagerModules.default
    ./hyprland
    ./persist.nix
    ./programs
  ];
}
