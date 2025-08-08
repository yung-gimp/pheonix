{
  pkgs,
  inputs,
  ...
}: {
  home = {
    packages = with pkgs; [
      htop
      tidal-hifi
      legcord
      vlc
      feh
      xfce.thunar
      neovide
    ];
  };

  imports = [
    inputs.nvf.homeManagerModules.default
    ./hyprland
    ./programs
  ];
}
