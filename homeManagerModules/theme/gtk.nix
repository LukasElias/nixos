{
  config,
  lib,
  ...
}: {
  options.myHomeManager.theme.gtk = {
    enable = lib.mkEnableOption "gtk theme";
  };

  config = lib.mkIf config.myHomeManager.theme.gtk.enable {
    gtk = {
      enable = true;
      colorScheme = "dark";
      font.name = config.myHomeManager.theme.font.defaultFonts.monospace.family;
    };
  };
}
