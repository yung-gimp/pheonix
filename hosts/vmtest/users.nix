{ config, lib, ... }:

let username = lib.attrsets.mapAttrsToList (name: "${name}") config.uc.users;

in

{
  options.uc.users.${username} = {
    uid = lib.mkOption {
      type = lib.types.int;
      default = "";
    };
    isAdmin = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    groups = lib.mkOption {
      type = lib.types.commas;
      default  = "";
    };
  };

  config.uc.users = {
    codman = {
      uid = "abcd";
      isAdmin = "true";
      groups = [
        "test"
      ];
    };
  };
}
