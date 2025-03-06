{ inputs, lib, ... }: let

  hosts = builtins.attrNames (inputs.nixpkgs.lib.attrsets.filterAttrs (name: type: type == "directory") (builtins.readDir ./.));

in {  ## Eventually a function returning flake
imports = builtins.map (host: ./. + /host) hosts;
}
