let

  mod = "SUPER";

in

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
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
        "${mod}, mouse:272, moveactive"
        "${mod}, mouse:273, resizeactive"
      ];

      monitor = [
        "desc:ASUSTek COMPUTER INC VG32VQ1B S9LMTF038670, 2560x1440@165, 0x0, 1"
        "desc:ASUSTek COMPUTER INC ASUS VG32VQ1B 0x0003A472, 2560x1440@90, 2560x-1120, 1, transform, 3"
      ];
      workspace = [
        "1, monitor:desc:ASUSTek COMPUTER INC VG32VQ1B S9LMTF038670, default:true"
        "2, monitor:desc:ASUSTek COMPUTER INC VG32VQ1B S9LMTF038670"
        "3, monitor:desc:ASUSTek COMPUTER INC VG32VQ1B S9LMTF038670"
        "4, monitor:desc:ASUSTek COMPUTER INC VG32VQ1B S9LMTF038670"
        "5, monitor:desc:ASUSTek COMPUTER INC ASUS VG32VQ1B 0x0003A472, default:true"
        "6, monitor:desc:ASUSTek COMPUTER INC ASUS VG32VQ1B 0x0003A472"
        "7, monitor:desc:ASUSTek COMPUTER INC ASUS VG32VQ1B 0x0003A472"
        "8, monitor:desc:ASUSTek COMPUTER INC ASUS VG32VQ1B 0x0003A472"
      ];

      general = {
        gaps_in = 2;
        gaps_out = 4;
      };

      decoration = {
        rounding = 4;
      };

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
}
