{ config, lib, ... }:

let

ucUsers = config.uc.users;

userConfig = {
     lib.mkif builtins.elem (ucUsers.${user}.type user) config.users.users.${user}.isNormalUser = true;
    };

in {
  config.users.users = builtins.map ( user: userConfig config.uc.users );

}
