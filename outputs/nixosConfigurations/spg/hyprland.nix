{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.gm.programs.hyprland;
in
{
  options.gm.programs.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland with UWSM";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      uwsm.enable = true;
      hyprland = {
        enable = true;
        withUWSM = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };
  };
}
