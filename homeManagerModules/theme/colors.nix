{
  config,
  lib,
  ...
}: let
  cfg = config.myHomeManager.theme.colors;
  colorChannelOption = lib.mkOption {
    type = lib.types.ints.between 0 255;
    description = "A value for one channel of an rgb color, so either red, green or blue";
  };
  colorOption = lib.mkOption {
    type = lib.types.submodule {
      options = {
        red = colorChannelOption;
        green = colorChannelOption;
        blue = colorChannelOption;
      };
    };
    description = "A color option";
  };
  fromHex = hex: {
    red = lib.fromHexString (lib.substring 0 2 hex);
    green = lib.fromHexString (lib.substring 2 2 hex);
    blue = lib.fromHexString (lib.substring 4 2 hex);
  };
  toHex = {
    red,
    green,
    blue,
  }:
    lib.concatStrings [
      (lib.toHexString red)
      (lib.toHexString green)
      (lib.toHexString blue)
    ];
  toRGB = {
    red,
    green,
    blue,
  }: [
    red
    green
    blue
  ];
  colorSchemeToX = convert: colorScheme: {
    sematicColors = lib.mapAttrs (name: value: convert value) colorScheme.sematicColors;
    namedColors = lib.mapAttrs (name: value: convert value) colorScheme.namedColors;
  };
  colorSchemeOption = description: readOnly:
    lib.mkOption {
      type = lib.types.submodule {
        options = {
          semanticColors = lib.mkOption {
            type = lib.types.submodule {
              options = {
                background = colorOption;
                surface = colorOption;
                text = colorOption;
                primary = colorOption;
                secondary = colorOption;
              };
            };
            description = "Colors with a meaning in the design";
            default = {
              background = fromHex "#1e1e2e";
              surface = fromHex "#313244";
              text = fromHex "#cdd6f4";
              primary = fromHex "#a6e3a1";
              secondary = fromHex "#94e2d5";
            };
          };

          namedColors = lib.mkOption {
            type = lib.types.submodule {
              options = {
                black = colorOption;
                blue = colorOption;
                brown = colorOption;
                cyan = colorOption;
                gray = colorOption;
                green = colorOption;
                grey = colorOption;
                lavender = colorOption;
                magenta = colorOption;
                maroon = colorOption;
                navy = colorOption;
                orange = colorOption;
                pink = colorOption;
                purple = colorOption;
                red = colorOption;
                teal = colorOption;
                violet = colorOption;
                white = colorOption;
                yellow = colorOption;
              };
            };
            default = rec {
              black = fromHex "000000";
              blue = fromHex "0000ff";
              brown = fromHex "a52a2a";
              cyan = fromHex "00ffff";
              gray = fromHex "808080";
              green = fromHex "00ff00";
              grey = gray;
              lavender = fromHex "e6e6fa";
              magenta = fromHex "ff00ff";
              maroon = fromHex "800000";
              navy = fromHex "000080";
              orange = fromHex "ffa500";
              pink = fromHex "ffc0cb";
              purple = fromHex "800080";
              red = fromHex "ff0000";
              teal = fromHex "008080";
              violet = fromHex "ee82ee";
              white = fromHex "ffffff";
              yellow = fromHex "ffff00";
            };
            description = "A bunch of named colors (defaults are from css)";
          };
        };
      };
      inherit description readOnly;
    };
in {
  options.myHomeManager.theme.colors = {
    enable = lib.mkEnableOption "colorscheme";
    colorScheme = colorSchemeOption "The value where you set the colorscheme" false;
    final = {
      hexColors = colorSchemeOption "The final colorscheme with hex codes" true;
      rgbColors = colorSchemeOption "The final colorscheme with rgb colors colors" true;
    };
  };

  config.myHomeManager.theme.colors = lib.mkIf cfg.enable {
    final = {
      hexColors = colorSchemeToX toHex cfg.colorScheme;
      rgbColors = colorSchemeToX toRGB cfg.colorScheme;
    };
  };
}
