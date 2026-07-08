{
  config,
  lib,
  ...
}: {
  options.myHomeManager.programs.graphical.firefox = {
    enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.firefox.enable {
    programs.firefox.enable = true;
  };
}
