{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHomeManager.programs.graphical.inkscape = {
    enable = lib.mkEnableOption "inkscape";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.inkscape.enable {
    home.packages = with pkgs; [
      inkscape
    ];
  };
}
