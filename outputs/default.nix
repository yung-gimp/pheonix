{
  self,
  inputs,
  lib,
  ...
}:
let

  hosts = builtins.attrNames (
    lib.attrsets.filterAttrs (_n: t: t == "directory") (builtins.readDir ./nixosConfigurations)
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

  homeCfgs = builtins.attrNames (
    lib.attrsets.filterAttrs (_n: t: t == "directory") (builtins.readDir ./homeConfigurations)
  );

  mkHomeCfg =
    homeCfg:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./homeConfigurations/${homeCfg}
      ];
    };

in
{
  flake = {
    nixosConfigurations = lib.genAttrs hosts mkHost;
    homeConfigurations = lib.genAttrs homeCfgs mkHomeCfg;
    # homeModules = lib.genAttrs homeMods mkHomeModule;
  };
}
