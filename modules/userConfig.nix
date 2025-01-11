{ config, options, pkgs, lib, ... }:

 {
  options = {
    uc = lib.mkOption {
      type = lib.types.attrs;
    };
  };

  config.uc = {
    codman = {
      initialPassword = "password";
      isNormalUser = true;
      extraGroups = [ "wheel" ]; 
      packages = with pkgs; [
        firefox
        tree
      ];
    };
  };
  config.users.users = config.uc;
}
