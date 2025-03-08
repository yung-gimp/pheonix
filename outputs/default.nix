{ self, inputs, lib, ... }:
let

  hosts = builtins.attrNames (
    inputs.nixpkgs.lib.attrsets.filterAttrs (_name: type: type == "directory") (builtins.readDir ./nixosConfigurations)
  );

  mkHost =
    hostname:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          hostname
          lib
          self
          ;
      };
      modules = [
        ./nixosConfigurations/${hostname}
        inputs.home-manager.nixosModules.home-manager
        inputs.impermanence.nixosModules.impermanence
      ];
    };
in
{
  flake = {
    nixosConfigurations = lib.genAttrs hosts mkHost;
  };
}
