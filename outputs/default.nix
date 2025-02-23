{ inputs, ... }: let

  outputDirs = builtins.attrNames (inputs.nixpkgs.lib.attrsets.filterAttrs (name: type: type == "directory") (builtins.readDir ./.));

  osConfigs = {};

in {
  nixosConfigurations = {
    
  };
}
