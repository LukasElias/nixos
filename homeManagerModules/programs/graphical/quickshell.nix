{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHomeManager.programs.graphical.quickshell = {
    enable = lib.mkEnableOption "quickshell";
    configName = lib.mkOption {
      type = lib.types.str;
      default = "default";
    };
    font = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
          };
          size = lib.mkOption {
            type = lib.types.int;
            default = 16;
          };
        };
      };
    };
    logoutmenuButtons = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          text = lib.mkOption { type = lib.types.str; };
          keybind = lib.mkOption { type = lib.types.str; };
          command = lib.mkOption { type = lib.types.str; };
        };
      });
    };
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.quickshell.enable (let
    quickshellConfigFile = pkgs.writeTextDir "config.js" ''
      const palette = {
        base00: "${config.colorScheme.palette.base00}",
        base01: "${config.colorScheme.palette.base01}",
        base02: "${config.colorScheme.palette.base02}",
        base03: "${config.colorScheme.palette.base03}",
        base04: "${config.colorScheme.palette.base04}",
        base05: "${config.colorScheme.palette.base05}",
        base06: "${config.colorScheme.palette.base06}",
        base07: "${config.colorScheme.palette.base07}",
        base08: "${config.colorScheme.palette.base08}",
        base09: "${config.colorScheme.palette.base09}",
        base0A: "${config.colorScheme.palette.base0A}",
        base0B: "${config.colorScheme.palette.base0B}",
        base0C: "${config.colorScheme.palette.base0C}",
        base0D: "${config.colorScheme.palette.base0D}",
        base0E: "${config.colorScheme.palette.base0E}",
        base0F: "${config.colorScheme.palette.base0F}"
      }

      const font = {
        family: "${config.myHomeManager.programs.graphical.quickshell.font.name}",
        pixelSize: ${lib.toString config.myHomeManager.programs.graphical.quickshell.font.size}
      }

      const notifications = {
        timeout: 5000
      }

      const logoutmenu = {
        buttons: ${lib.toJSON config.myHomeManager.programs.graphical.quickshell.logoutmenuButtons}
      }
    '';
    quickshellConfigDrv = pkgs.symlinkJoin {
      name = "quickshellConfig";
      paths = [
        quickshellConfigFile
        ../../../config/quickshell
      ];
    };
  in {
    programs.quickshell = {
      enable = true;
      systemd.enable = true;
      activeConfig = config.myHomeManager.programs.graphical.quickshell.configName;
      configs = {
        "${config.myHomeManager.programs.graphical.quickshell.configName}" = quickshellConfigDrv;
      };
    };
  });
}
