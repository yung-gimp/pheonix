{
  self,
  inputs,
  lib,
  ...
}:
let

  hosts = builtins.attrNames (
    inputs.nixpkgs.lib.attrsets.filterAttrs (_name: type: type == "directory") (builtins.readDir ./.)
  );

  mkHost =
    hostname:
    self.inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          hostname
          lib
          self
          ;
      };
      modules = [
        ./${hostname}
        inputs.home-manager.nixosModules.home-manager
      ];
    };

in
{
  flake.nixosConfigurations = lib.genAttrs hosts mkHost;
}
