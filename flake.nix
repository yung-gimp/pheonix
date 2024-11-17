{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, impermanence, home-manager, ... } @inputs: {
    nixosConfigurations.Large-Penix-Gaming = nixpkgs.lib.nixosSystem {
      system = "x86_64-Linux";
      specialArgs = {inherit inputs;};
      modules = [
        impermanence.nixosModules.impermanence
        ./configuration.nix
        ./persist.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.codman = import ./home.nix;
        }
      ];
    };
  };
}
