{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.myWrappers.services.hypridle;
  mkTypeOption = type: nullable: description:
    lib.mkOption {
      type =
        if nullable
        then lib.types.nullOr type
        else type;
      inherit description;
    };
  mkStringOption = mkTypeOption lib.types.str;
  mkIntOption = mkTypeOption lib.types.int;
  mkBoolOption = mkTypeOption lib.types.bool;
in {
  options.myWrappers.services.hypridle = {
    enable = lib.mkEnableOption "hypridle wrapper";
    wrapperPackage = lib.mkOption {
      type = lib.types.package;
      description = "wrapper package for hypridle";
    };
    settings = lib.mkOption {
      type = lib.types.submodule {
        options = {
          general = lib.mkOption {
            type = lib.types.submodule {
              options = {
                lock_cmd = mkStringOption true "command to run when receiving a dbus lock event";
                before_sleep_cmd = mkStringOption true "command to run when receiving a dbus prepare_sleep event";
                after_sleep_cmd = mkStringOption true "command to run when receiving a dbus post prepare_sleep event";
              };
            };
          };
          listener = lib.mkOption {
            type = lib.types.listOf (lib.types.submodule {
              options = {
                timeout = mkIntOption false "Idle time in seconds.";
                on-timeout = mkStringOption true "Command to run when timeout has passed.";
                on-resume = mkStringOption true "Command to run when activity is detected after timeout has fired.";
              };
            });
          };
        };
      };
      default = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
        };
        listener = [
          {
            timeout = 150; # 2.5min: Turn backlight down
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 300; # 5min: Lock the session
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 330; # 5.5min: Turn off the screen
            on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
            on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' && brightnessctl -r";
          }
          {
            timeout = 1800; # 30min: Suspend the system
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };

  config = {
    myWrappers.services.hypridle.wrapperPackage =
      (inputs.wrappers.wrapperModules.hypridle.apply {
        inherit pkgs;
        inherit (cfg) settings;
      }).wrapper;
    environment.systemPackages = [
      cfg.wrapperPackage
    ];
  };
}
