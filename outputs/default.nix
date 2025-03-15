{
  self,
  inputs,
  lib,
  ...
}:
let

  hosts = builtins.attrNames (
    inputs.nixpkgs.lib.attrsets.filterAttrs (_name: type: type == "directory") (
      builtins.readDir ./nixosConfigurations
    )
  );

  mkHost =
    hostname:
    inputs.nixpkgs.lib.nixosSystem {

      specialArgs = {
        pkgs-stable = import inputs.nixpkgs-stable {
          system = "x86_64-linux";
        };

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
    imports = [ ./homeManagerModules ];
  };
}
