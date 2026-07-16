{
  config,
  lib,
  ...
}: {
  imports = [
    ./firefox.nix
    ./kitty.nix
    ./quickshell.nix
    ./steam.nix
    ./blender.nix
    ./hyprlock.nix
    ./prismlauncher.nix
    ./discord.nix
  ];

  options.myHomeManager.programs.graphical = {
    enable = lib.mkEnableOption "graphical programs";
  };

  config.myHomeManager.programs.graphical = lib.mkIf config.myHomeManager.programs.graphical.enable {
    firefox.enable = lib.mkDefault true;

    kitty = {
      enable = lib.mkDefault true;
      font = lib.mkDefault {
        name = config.myHomeManager.theme.font.defaultFonts.monospace.family;
        package = config.myHomeManager.theme.font.defaultFonts.monospace.package;
      };
    };

    quickshell = {
      enable = lib.mkDefault true;
      font.name = lib.mkDefault config.myHomeManager.theme.font.defaultFonts.monospace.family;
      logoutmenuButtons = lib.mkDefault [
        {
          text = "Lock";
          keybind = "l";
          command = [
            "sh"
            "-c"
            "pidof hyprlock || hyprlock"
          ];
        }
        {
          text = "Shutdown";
          keybind = "s";
          command = [
            "hyprctl"
            "dispatch"
            "hl.dsp.exec_cmd(\"hyprshutdown --post-cmd 'systemctl poweroff'\")"
          ];
        }
        {
          text = "Reboot";
          keybind = "r";
          command = [
            "hyprctl"
            "dispatch"
            "hl.dsp.exec_cmd(\"hyprshutdown -t 'Rebooting...' --post-cmd 'systemctl reboot'\")"
          ];
        }
        {
          text = "Hibernate";
          keybind = "h";
          command = [
            "systemctl"
            "hibernate"
          ];
        }
        {
          text = "Logout";
          keybind = "o";
          command = [
            "hyprctl"
            "dispatch"
            "hl.dsp.exec_cmd(\"hyprshutdown -t 'Logging out...'\")"
          ];
        }
        {
          text = "Suspend";
          keybind = "u";
          command = [
            "systemctl"
            "suspend"
          ];
        }
      ];
    };

    hyprlock.enable = lib.mkDefault true;

    steam.enable = lib.mkDefault true;

    blender.enable = lib.mkDefault true;

    prismlauncher.enable = lib.mkDefault true;
    
    discord.enable = lib.mkDefault true;
  };
}
