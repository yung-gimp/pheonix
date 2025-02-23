{ lib, ... }: let

  outputDirs = builtins.attrNames (lib.attrsets.filterAttrs (name: type: type == "directory") (builtins.readDir ./));

  

in {
  nixosConfigurations = {
    
  };
}
