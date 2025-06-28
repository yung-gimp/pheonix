{
  self,
  inputs,
  lib,
  ...
}:
let

  hosts = builtins.attrNames (
    inputs.nixpkgs.lib.attrsets.filterAttrs (_n: t: t == "directory") (
      builtins.readDir ./nixosConfigurations
    )
  );

  homes = builtins.attrNames (
    inputs.nixpkgs.lib.attrsets.filterAttrs (_n: t: t == "directory") (builtins.readDir ./homeModules)
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

  mkHome = user: {
    specialArgs = {
      inherit user lib;
    };
    modules = [
      ./homeModules/${user}
    ];
  };

in
{
  flake = {
    nixosConfigurations = lib.genAttrs hosts mkHost;
    homeModules = lib.genAttrs homes mkHome;
  };
}
