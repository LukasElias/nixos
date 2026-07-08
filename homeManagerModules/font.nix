{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHomeManager.font = {
    enable = lib.mkEnableOption "font config";

    defaultFonts = {
      monospace = lib.mkOption {
        type = lib.types.nullOr (lib.types.submodule {
          options = {
            package = lib.mkOption {
              type = lib.types.package;
            };
            family = lib.mkOption {
              type = lib.types.str;
            };
          };
        });

        default = {
          package = pkgs.nerd-fonts.agave;
          family = "AgaveNerdFont";
        };
      };

      serif = lib.mkOption {
        type = lib.types.nullOr (lib.types.submodule {
          options = {
            package = lib.mkOption {
              type = lib.types.package;
            };
            family = lib.mkOption {
              type = lib.types.str;
            };
          };
        });
      };

      sansSerif = lib.mkOption {
        type = lib.types.nullOr (lib.types.submodule {
          options = {
            package = lib.mkOption {
              type = lib.types.package;
            };
            family = lib.mkOption {
              type = lib.types.str;
            };
          };
        });
      };
    };
  };

  config =
    lib.mkIf config.myHomeManager.font.enable
    (let
      filteredFonts = lib.filterAttrs (_: fonts: fonts != null) config.myHomeManager.font.defaultFonts;
    in {
      fonts.fontconfig.enable = true;

      fonts.fontconfig.defaultFonts = lib.mapAttrs (_: fontConfig: [fontConfig.family]) filteredFonts;

      home.packages = lib.mapAttrsToList (_: fontConfig: fontConfig.package) filteredFonts;
    });
}
