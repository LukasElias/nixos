{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHomeManager.programs.graphical.blender = {
    enable = lib.mkEnableOption "blender";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.blender.enable {
    home.packages = with pkgs; [
      blender
    ];
  };
}
