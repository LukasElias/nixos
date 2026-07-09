{
  config,
  lib,
  ...
}: {
  options.myHomeManager.programs.terminal.dircolors = {
    enable = lib.mkEnableOption "dircolors";
  };

  config = lib.mkIf config.myHomeManager.programs.terminal.dircolors.enable {
    programs.dircolors = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
