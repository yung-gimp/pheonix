{ config, lib, ... }:
let
  cfg = config.cm.hyprland;
in
{
  wayland.windowManager.hyprland.settings = lib.mkIf cfg.enable {
    general = {
      gaps_in = 2;
      gaps_out = 4;
    };

    decoration = {
      rounding = 4;
    };
  };
}
