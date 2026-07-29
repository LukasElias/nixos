{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.myHomeManager.theme.cursor;
in {
  options.myHomeManager.theme.cursor = {
    enable = lib.mkEnableOption "cursor theme";
    theme = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "catppuccin-mocha-green-cursors";
          };
          package = lib.mkPackageOption pkgs "catppuccin-cursors.mochaGreen" {};
          size = lib.mkOption {
            type = lib.types.int;
            default = 24;
          };
        };
      };
      default = {
        name = "catppuccin-mocha-green-cursors";
        package = pkgs.catppuccin-cursors.mochaGreen;
        size = 24;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      hyprcursor.enable = true;

      inherit (cfg.theme) name package size;
    };
  };
}
