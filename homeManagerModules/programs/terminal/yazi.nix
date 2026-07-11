{
  config,
  lib,
  ...
}: {
  options.myHomeManager.programs.terminal.yazi = {
    enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf config.myHomeManager.programs.terminal.yazi.enable {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      shellWrapperName = "y";
    };
  };
}
