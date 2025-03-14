{
  description = "big gimpin";

  nixConfig = {

    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        inputs.fpFmt.flakeModule
        ./outputs
      ];
    };

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    fpFmt = {
      url = "github:freedpom/FreedpomFormatter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ff = {
      url = "github:freedpom/FreedpomFlake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    impermanence.url = "github:nix-community/impermanence";

    hyprland.url = "github:hyprwm/Hyprland";
  };
}
