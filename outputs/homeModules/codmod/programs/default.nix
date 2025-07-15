{
  imports = [
    ./firefox.nix
    ./foot.nix
    ./git.nix
    ./media.nix
    ./nvf.nix
  ];
  programs = {
    home-manager.enable = true;
    foot.enable = true;
    rofi.enable = true;
  };
}
