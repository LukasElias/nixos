{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myHomeManager.programs.graphical.plex;
in {
  options.myHomeManager.programs.graphical.plex = {
    enable = lib.mkEnableOption "plex";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      plex-desktop
      plexamp
    ];
  };
}
