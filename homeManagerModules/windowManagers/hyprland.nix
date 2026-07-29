{
  lib,
  pkgs,
  config,
  ...
}: {
  options.myHomeManager.windowManagers.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf config.myHomeManager.windowManagers.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      configType = "lua";
      package = null;
      portalPackage = null;

      settings = {
        terminal._var = "kitty";
        menu._var = "fuzzel";
        music_player._var = "spotify";
        browser._var = "firefox";
        discord = lib.mkIf config.myHomeManager.programs.graphical.discord.enable {
          _var = "discord";
        };
        synologyDriveClient = lib.mkIf config.myHomeManager.programs.graphical.synologyDriveClient.enable {
          _var = "synology-drive";
        };
        logoutmenu._var = "qs ipc call logoutmenu toggle";
        notification_center._var = {
          toggle = "qs ipc call notifications toggle";
          clear_notifications = "qs ipc call notifications clearNotifications";
        };

        monitor = {
          output = "eDP-1";
          mode = "1920x1200@60";
          position = "0x0";
          scale = 1;
        };

        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''              function ()
                            hl.exec_cmd(music_player)
                            hl.exec_cmd(browser)
                            ${lib.optionalString config.myHomeManager.programs.graphical.discord.enable "hl.exec_cmd(discord)"}
                            ${lib.optionalString config.myHomeManager.programs.graphical.synologyDriveClient.enable "hl.exec_cmd(synologyDriveClient)"}
                          end'')
          ];
        };

        config = {
          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            col = {
              active_border = {
                colors = [
                  "rgb(${config.colorScheme.palette.base0B})"
                  "rgb(${config.colorScheme.palette.base0E})"
                ];
                angle = 45;
              };
              inactive_border = {
                colors = [
                  "rgb(${config.colorScheme.palette.base0A})"
                  "rgb(${config.colorScheme.palette.base0F})"
                ];
                angle = 45;
              };
            };
            resize_on_border = true;
            allow_tearing = false;
            layout = "dwindle";
          };
          decoration = {
            blur.enabled = false;
            shadow.enabled = false;
          };
          animations.enabled = false;
          dwindle.preserve_split = true;
          misc.force_default_wallpaper = 0;
          input = {
            kb_layout = "dk";
            follow_mouse = 1;
            sensitivity = 0;
            repeat_delay = 300;
            repeat_rate = 50;
            touchpad = {
              natural_scroll = true;
            };
          };
        };
        gesture = {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        };
        window_rule = [
          {
            name = "Browser on workspace 2";
            match.initial_class = lib.generators.mkLuaInline "\"(?i)\" .. browser";
            workspace = "2 silent";
          }
          {
            name = "Music Player on workspace 3";
            match.initial_class = lib.generators.mkLuaInline "\"(?i)\" .. music_player";
            workspace = "3 silent";
          }
          (lib.optionalAttrs config.myHomeManager.programs.graphical.discord.enable {
            name = "Discord on workspace 4";
            match.initial_class = lib.generators.mkLuaInline "\"(?i)\" .. discord";
            workspace = "4 silent";
          })
        ];

        # ----------------binds-----------------
        main_mod._var = "SUPER";
        bind = let
          bindKey = {
            key,
            dispatcher,
            flags ? null,
            mainMod ? true,
          }: {
            _args = [
              (
                if mainMod
                then (lib.generators.mkLuaInline "main_mod .. \" + ${key}\"")
                else " + ${key}"
              )
              (lib.generators.mkLuaInline "${dispatcher}")
              flags
            ];
          };
          directionKeys = {
            H = "left";
            J = "up";
            K = "down";
            L = "right";
          };
        in
          [
            # Binds for stuff
            (bindKey {
              key = "Q";
              dispatcher = "hl.dsp.exec_cmd(terminal)";
            })
            (bindKey {
              key = "B";
              dispatcher = "hl.dsp.exec_cmd(browser)";
            })
            (bindKey {
              key = "M";
              dispatcher = "hl.dsp.exec_cmd(logoutmenu)";
            })
            (bindKey {
              key = "N";
              dispatcher = "hl.dsp.exec_cmd(notification_center.toggle)";
            })
            (bindKey {
              key = "SHIFT + N";
              dispatcher = "hl.dsp.exec_cmd(notification_center.clear_notifications)";
            })
            (bindKey {
              key = "V";
              dispatcher = "hl.dsp.window.float({ action = \"toggle\" })";
            })
            (bindKey {
              key = "R";
              dispatcher = "hl.dsp.exec_cmd(menu)";
            })
            (bindKey {
              key = "T";
              dispatcher = "hl.dsp.layout(\"togglesplit\")";
            })
            # bindMainMod { key = "E"; dispatcher = "hl.dsp.exec_cmd(bemoji -t)"; }
            (bindKey {
              key = "C";
              dispatcher = "hl.dsp.window.close()";
            })
            (bindKey {
              key = "P";
              dispatcher = "hl.dsp.window.pin({ action = \"toggle\" })";
            })
            (bindKey {
              key = "F11";
              dispatcher = "hl.dsp.window.fullscreen({ action = \"toggle\" })";
              mainMod = false;
            })

            # Binds for audio / media
            (bindKey {
              key = "XF86AudioRaiseVolume";
              dispatcher = "hl.dsp.exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+\")";
              flags = {
                locked = true;
                repeating = true;
              };
              mainMod = false;
            })
            (bindKey {
              key = "XF86AudioLowerVolume";
              dispatcher = "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")";
              flags = {
                locked = true;
                repeating = true;
              };
              mainMod = false;
            })
            (bindKey {
              key = "XF86AudioMute";
              dispatcher = "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")";
              flags = {
                locked = true;
                repeating = true;
              };
              mainMod = false;
            })
            (bindKey {
              key = "XF86AudioMicMute";
              dispatcher = "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")";
              flags = {
                locked = true;
                repeating = true;
              };
              mainMod = false;
            })
            (bindKey {
              key = "XF86MonBrightnessUp";
              dispatcher = "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%+\")";
              flags = {
                locked = true;
                repeating = true;
              };
              mainMod = false;
            })
            (bindKey {
              key = "XF86MonBrightnessDown";
              dispatcher = "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%-\")";
              flags = {
                locked = true;
                repeating = true;
              };
              mainMod = false;
            })
            (bindKey {
              key = "XF86AudioNext";
              dispatcher = " hl.dsp.exec_cmd(\"playerctl next\")";
              flags.locked = true;
              mainMod = false;
            })
            (bindKey {
              key = "XF86AudioPause";
              dispatcher = "hl.dsp.exec_cmd(\"playerctl play-pause\")";
              flags.locked = true;
              mainMod = false;
            })
            (bindKey {
              key = "XF86AudioPlay";
              dispatcher = " hl.dsp.exec_cmd(\"playerctl play-pause\")";
              flags.locked = true;
              mainMod = false;
            })
            (bindKey {
              key = "XF86AudioPrev";
              dispatcher = " hl.dsp.exec_cmd(\"playerctl previous\")";
              flags.locked = true;
              mainMod = false;
            })

            (bindKey {
              key = "right";
              dispatcher = " hl.dsp.exec_cmd(\"playerctl next\")";
              flags.locked = true;
            })
            (bindKey {
              key = "Space";
              dispatcher = "hl.dsp.exec_cmd(\"playerctl play-pause\")";
              flags.locked = true;
            })
            (bindKey {
              key = "left";
              dispatcher = " hl.dsp.exec_cmd(\"playerctl previous\")";
              flags.locked = true;
            })

            # Binds for moving/resizing windows with mouse
            (bindKey {
              key = "mouse:272";
              dispatcher = "hl.dsp.window.drag()";
              flags.mouse = true;
            })
            (bindKey {
              key = "mouse:273";
              dispatcher = "hl.dsp.window.resize()";
              flags.mouse = true;
            })
          ]
          # Binds for windows
          ++ (lib.mapAttrsToList (key: direction:
            bindKey {
              inherit key;
              dispatcher = "hl.dsp.focus({ direction = \"${direction}\" })";
            })
          directionKeys)
          ++ (lib.mapAttrsToList (key: direction:
            bindKey {
              key = "SHIFT + ${key}";
              dispatcher = "hl.dsp.window.move({ direction = \"${direction}\" })";
            })
          directionKeys)
          # Binds for workspaces
          ++ (lib.genList
            (i:
              bindKey {
                key = toString (lib.mod (i + 1) 10);
                dispatcher = "hl.dsp.focus({ workspace = \"${toString (i + 1)}\" })";
              })
            10)
          ++ (lib.genList
            (i:
              bindKey {
                key = "SHIFT + ${toString (lib.mod (i + 1) 10)}";
                dispatcher = "hl.dsp.window.move({ workspace = \"${toString (i + 1)}\" })";
              })
            10);
      };
    };

    home.packages = with pkgs; [
      hyprshutdown
      playerctl
      brightnessctl
    ];
  };
}
