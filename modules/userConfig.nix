{ lib, ... }:

{
  options.uc.users = lib.mkOption {
    type = lib.types.attrs {
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
  };
}
