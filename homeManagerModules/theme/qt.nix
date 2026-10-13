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
      # Not rly a reproducible setting
      platformTheme.name = "qtct";
      # style = {
      #   name = "breeze";
      #   package = pkgs.kdePackages.breeze;
      # };
    };
  };
}
