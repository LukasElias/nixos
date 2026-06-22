{
  config,
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;

    configType = "hyprlang";
    package = null;
    portalPackage = null;

    settings = {
      "$terminal" = "kitty";
      "$menu" = "fuzzel";
      "$browser" = "firefox";
      "$launchPrefix" = "";

      monitor = [
        "eDP-1,1920x1200@60,auto-center-down,1"
        "HDMI-A-1,2560x1440@60,auto-center-up,1"
      ];

      exec-once = [
        "[workspace 2 silent] $browser"
        "[workspace 3 silent] spotify"
      ];

      workspace = [
        "1,monitor:eDP-1"
        "3,monitor:eDP-1"
        "2,monitor:HDMI-A-1"
        "4,monitor:HDMI-A-1"
      ];

      windowrule = "match:class Spotify, workspace 3 silent";

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb(${config.colorScheme.palette.base0B}) rgb(${config.colorScheme.palette.base0E}) 45deg";
        "col.inactive_border" = "rgb(${config.colorScheme.palette.base0A}) rgb(${config.colorScheme.palette.base0F}) 45deg";
        resize_on_border = true;
        allow_tearing = false;
        layout = "pseudo";
      };

      decoration = {
        rounding = 10;

        blur.enabled = false;
        shadow.enabled = false;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 4, default, popin 80%"
          "border, 1, 4, default"
          "borderangle, 1, 4, default"
          "fade, 1, 4, default"
          "workspaces, 0"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      master = {
        new_status = "master";
        orientation = "left";
      };

      input = {
        kb_layout = "dk";
        follow_mouse = 1;
        sensitivity = 0;
        repeat_delay = 300;
        repeat_rate = 50;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.7;
        };
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, $launchPrefix $terminal"
        "$mainMod, F, exec, $launchPrefix $browser"
        "$mainMod, M, exec, wlogout -s"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu --launch-prefix='$launchPrefix'"
        "$mainMod, T, layoutmsg, togglesplit, # dwindle"
        # "$mainMod, I, exec, grim -g "$(slurp)" # Take a screenshot"
        "$mainMod, E, exec, bemoji -t"
        "$mainMod, C, killactive"
        "$mainMod, P, pin"
        ", F11, fullscreen, 0"
        "$mainMod, P, layoutmsg, pseudo, # dwindle"
        "$mainMod, A, layoutmsg, rollnext # master"
        "$mainMod, D, layoutmsg, rollprev # master"

        "$mainMod, Space, exec, playerctl play-pause"
        "$mainMod, right, exec, playerctl next"
        "$mainMod, left, exec, playerctl previous"

        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        "$mainMod SHIFT, H, swapwindow, l"
        "$mainMod SHIFT, L, swapwindow, r"
        "$mainMod SHIFT, K, swapwindow, u"
        "$mainMod SHIFT, J, swapwindow, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];
    };
  };
}
