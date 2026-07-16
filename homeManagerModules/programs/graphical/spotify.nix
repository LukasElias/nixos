{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHomeManager.programs.graphical.spotify = {
    enable = lib.mkEnableOption "spotify";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.spotify.enable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
