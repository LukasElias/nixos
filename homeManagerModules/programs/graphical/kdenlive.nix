{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHomeManager.programs.graphical.kdenlive;
in {
  options.myHomeManager.programs.graphical.kdenlive = {
    enable = lib.mkEnableOption "kdenlive";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.kdenlive
    ];
  };
}
