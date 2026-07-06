{
  lib,
  config,
  ...
}: {
  options.kitty = {
    enable = lib.mkEnableOption "kitty";
    font = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
          };
          package = lib.mkOption {
            type = lib.types.package;
          };
        };
      };
    };
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;

      settings = {
        enable_audio_bell = false;
        scrollback_lines = 1000;
        tab_bar_align = "center";
        background_opacity = 0.95;

        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";

        color0 = "#${config.colorScheme.palette.base03}";
        color8 = "#${config.colorScheme.palette.base04}";

        color1 = "#${config.colorScheme.palette.base08}";
        color9 = "#${config.colorScheme.palette.base08}";

        color2 = "#${config.colorScheme.palette.base0B}";
        color10 = "#${config.colorScheme.palette.base0B}";

        color3 = "#${config.colorScheme.palette.base0A}";
        color11 = "#${config.colorScheme.palette.base0A}";

        color4 = "#${config.colorScheme.palette.base0D}";
        color12 = "#${config.colorScheme.palette.base0D}";

        color5 = "#${config.colorScheme.palette.base0E}";
        color13 = "#${config.colorScheme.palette.base0E}";

        color6 = "#${config.colorScheme.palette.base0C}";
        color14 = "#${config.colorScheme.palette.base0C}";

        color7 = "#${config.colorScheme.palette.base05}";
        color15 = "#${config.colorScheme.palette.base07}";
      };

      font = config.kitty.font;

      shellIntegration.mode = null;

      extraConfig = "shell_integration no-cursor";
    };
  };
}
