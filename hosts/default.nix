{ inputs, ... }: let

  hostNames = builtins.attrNames (inputs.nixpkgs.lib.attrsets.filterAttrs (name: type: type == "directory") (builtins.readDir ./.));

in {
  imports = builtins.map (host: ./${host}) hostNames;
}
