{
  config,
  lib,
  ...
}: {
  options.myHomeManager.programs.graphical.discord = {
    enable = lib.mkEnableOption "discord";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.discord.enable {
    programs.discord = {
      enable = true;
      settings = {
        MINIMIZE_TO_TRAY = false;
      };
    };
  };
}
