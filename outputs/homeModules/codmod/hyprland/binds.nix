{ config, lib, ... }:
let
  cfg = config.cm.hyprland;
  mod = "SUPER";
in
{
  wayland.windowManager.hyprland.settings = lib.mkIf cfg.enable {
    bind = [
      "${mod}, C, killactive,"
      "${mod} SHIFT, C, forcekillactive,"
      "${mod}, M, exec, hyprctl dispatch exit"
      "${mod}, Q, exec, foot"
      "${mod}, R, exec, rofi -show drun"

      "${mod}, mouse_down, workspace, e-1"
      "${mod}, mouse_up, workspace, e+1"

      "${mod}, h, movefocus, l"
      "${mod}, j, movefocus, d"
      "${mod}, k, movefocus, u"
      "${mod}, l, movefocus, r"

      "${mod}, 1, workspace, 1"
      "${mod}, 2, workspace, 2"
      "${mod}, 3, workspace, 3"
      "${mod}, 4, workspace, 4"
      "${mod} ALT, 1, workspace, 5"
      "${mod} ALT, 2, workspace, 6"
      "${mod} ALT, 3, workspace, 7"
      "${mod} ALT, 4, workspace, 8"
      "${mod} SHIFT, 1, movetoworkspace, 1"
      "${mod} SHIFT, 2, movetoworkspace, 2"
      "${mod} SHIFT, 3, movetoworkspace, 3"
      "${mod} SHIFT, 4, movetoworkspace, 4"
      "${mod} ALT SHIFT, 1, movetoworkspace, 5"
      "${mod} ALT SHIFT, 2, movetoworkspace, 6"
      "${mod} ALT SHIFT, 3, movetoworkspace, 7"
      "${mod} ALT SHIFT, 4, movetoworkspace, 8"
    ];

    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];
  };
}
