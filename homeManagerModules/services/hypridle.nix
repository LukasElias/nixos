{
  config,
  lib,
  ...
}: {
  options.myHomeManager.services.hypridle = {
    enable = lib.mkEnableOption "hypridle";
  };

  config = lib.mkIf config.myHomeManager.services.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
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
}
