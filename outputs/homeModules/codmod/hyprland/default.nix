{ config, lib, ... }:
let
  cfg = config.cm.hyprland;
in
{
  options.cm.hyprland.enable = lib.mkEnableOption "Enable hyprland";

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        xwayland = {
          enabled = true;
          force_zero_scaling = false;
          use_nearest_neighbor = true;
        };
      };
    };
  };
  imports = [
    ./appearance.nix
    ./binds.nix
    ./displays.nix
  ];
}
