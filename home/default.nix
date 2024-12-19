{ config, lib, pkgs, inputs, ... }:
let
  userNames = builtins.attrNames (pkgs.lib.attrsets.filterAttrs (user: user.isNormalUser) users.users);
in {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users = lib.mkMerge 
    (builtins.map (user:
      lib.mkIf (builtins.pathExists ./${user}) {${user}.imports = [ ./${user} ];}
    ) userNames);
}
