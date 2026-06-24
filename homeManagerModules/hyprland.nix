{
  lib,
  config,
  ...
}: {
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

      monitor = {
        output = "eDP-1";
        mode = "1920x1200@60";
        position = "0x0";
        scale = 1;
      };

      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''            function ()
                        hl.exec_cmd(music_player)
                        hl.exec_cmd(browser)
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
      # window_rule = {
      #
      # };

      # ----------------binds-----------------
      main_mod._var = "SUPER";
      bind = let
        bindMainMod = {
          key,
          dispatcher,
          flags ? {},
        }: {
          _args = [
            (lib.generators.mkLuaInline "main_mod .. \" + ${key}\"")
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
          # My binds for stuff
          (bindMainMod {
            key = "Q";
            dispatcher = "hl.dsp.exec_cmd(terminal)";
          })
          (bindMainMod {
            key = "B";
            dispatcher = "hl.dsp.exec_cmd(browser)";
          })
          (bindMainMod {
            key = "M";
            dispatcher = "hl.dsp.exec_cmd(\"wlogout -s\")";
          })
          (bindMainMod {
            key = "V";
            dispatcher = "hl.dsp.window.float({ action = \"toggle\" })";
          })
          (bindMainMod {
            key = "R";
            dispatcher = "hl.dsp.exec_cmd(menu)";
          })
          (bindMainMod {
            key = "T";
            dispatcher = "hl.dsp.layout(\"togglesplit\")";
          })
          # bindMainMod { key = "E"; dispatcher = "hl.dsp.exec_cmd(bemoji -t)"; }
          (bindMainMod {
            key = "C";
            dispatcher = "hl.dsp.window.kill()";
          })
          (bindMainMod {
            key = "P";
            dispatcher = "hl.dsp.window.pin({ action = \"toggle\" })";
          })
          (bindMainMod {
            key = "F11";
            dispatcher = "hl.dsp.window.fullscreen({ action = \"toggle\" })";
          })
        ]
        # Binds for windows
        ++ (lib.mapAttrsToList (key: direction:
          bindMainMod {
            inherit key;
            dispatcher = "hl.dsp.focus({ direction = \"${direction}\" })";
          })
        directionKeys)
        ++ (lib.mapAttrsToList (key: direction:
          bindMainMod {
            key = "SHIFT + ${key}";
            dispatcher = "hl.dsp.window.move({ direction = \"${direction}\" })";
          })
        directionKeys)
        # Binds for workspaces
        ++ (lib.genList
          (i:
            bindMainMod {
              key = toString (lib.mod (i + 1) 10);
              dispatcher = "hl.dsp.focus({ workspace = \"${toString (i + 1)}\" })";
            })
          10)
        ++ (lib.genList
          (i:
            bindMainMod {
              key = "SHIFT + ${toString (lib.mod (i + 1) 10)}";
              dispatcher = "hl.dsp.window.move({ workspace = \"${toString (i + 1)}\" })";
            })
          10);
    };
  };
}
