{
  config,
  lib,
  ...
}: {
  options.myHomeManager.xdg = {
    enable = lib.mkEnableOption "xdg";
  };

  config = lib.mkIf config.myHomeManager.xdg.enable {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
