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
    inputs.nixpkgs.lib.attrsets.filterAttrs (_n: t: t == "directory") (builtins.readDir ./homeConfigurations)
  );

  mkHomeCfg = homeCfg: {
    specialArgs = {
      inherit lib;
    };
    modules = [
      ./homeConfigurations/${homeCfg}
    ];
  };

  homeMods = builtins.attrNames (
    inputs.nixpkgs.lib.attrsets.filterAttrs (_n: t: t == "directory") (builtins.readDir ./homeModules)
  );

  mkHomeModule = modName: {
    specialArgs = {
      inherit modName lib;
    };
    modules = [
      ./homeModules/${modName}
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
