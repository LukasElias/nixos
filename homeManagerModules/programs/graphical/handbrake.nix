{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHomeManager.programs.graphical.handbrake;
in {
  options.myHomeManager.programs.graphical.handbrake = {
    enable = lib.mkEnableOption "handbrake";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      handbrake
    ];
  };
}
