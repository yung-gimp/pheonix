{ config, lib, ... }:

{
  options.cm = {
    perDir = lib.mkOption {
      type = lib.types.str;
      default = "/nix/persist/home/codman";
    };
  };

  config.home.persistence = {
    ${config.cm.perDir} = {
      directories = [
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        ".ssh"
        ".local/share/Steam"
      ];
      files = [ ];
      allowOther = false;
    };
  };
}
