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
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
      ];
      files = [ ];
      allowOther = false;
    };

    "/nix/persist/" = {
      directories = [
        {
          directory = "games";
          method = "symlink";
        }
      ];
    };
  };
}
