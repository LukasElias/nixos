{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHomeManager.programs.graphical.dolphin;
in {
  options.myHomeManager.programs.graphical.dolphin = {
    enable = lib.mkEnableOption "dolphin";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.dolphin
    ];
  };
}
