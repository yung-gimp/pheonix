{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, impermanence, home-manager, ... } @inputs: {
    nixosConfigurations.spg = nixpkgs.lib.nixosSystem {
      system = "x86_64-Linux";
      specialArgs = {inherit inputs;};
      modules = [
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        ./disk-config.nix
        ./persist.nix
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.codman = { ... }: {
            imports = {
              impermanence.homeManagerModules.impermanence
              ./home/persist.nix
              ./home.nix;
            };
          };
        }
      ];
    };
  };
}
