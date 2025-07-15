{ inputs, ... }:

{
  home = {
    username = "codman";
    homeDirectory = "/home/codman";
    stateVersion = "24.11";
  };

  nixpkgs.config.allowUnfree = true;

  cm = {
    programs = {
      firefox.enable = true;
      git.enable = true;
      media.enable = true;
      nvf.enable = true;
    };
  };

  imports = [ inputs.cm.homeModules.codmod ];
}
