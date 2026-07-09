{config, lib, ...}: let
  qtctSettings = {
    Appearance = {
      icon_theme = "Adwaita";
      standarddialogs = "xdgdesktopportal";
      style = "adwaita-dark";
    };
  };
in {
  options.myHomeManager.theme.qt = {
    enable = lib.mkEnableOption "qt theme";
  };

  config = lib.mkIf config.myHomeManager.theme.qt.enable {
    qt = {
      enable = true;

      platformTheme.name = "qtct";
      qt5ctSettings = qtctSettings;
      qt6ctSettings = qtctSettings;
    };
  };
}
