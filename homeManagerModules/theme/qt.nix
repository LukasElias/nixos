{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.myHomeManager.theme.qt;
in {
  options.myHomeManager.theme.qt = {
    enable = lib.mkEnableOption "qt theme";
  };

  config = lib.mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style = {
        name = "gtk2";
        package = pkgs.kdePackages.breeze;
      };
    };
  };
}
