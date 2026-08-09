{
  config,
  lib,
  ...
}: let
  cfg = config.myWrappers.programs.graphical;
in {
  options.myWrappers.programs.graphical = {
    enable = lib.mkEnableOption "graphical program wrappers";
  };

  imports = [
    ./kitty.nix
  ];

  config.myWrappers.programs.graphical = lib.mkIf cfg.enable {
    kitty.enable = lib.mkDefault true;
  };
}
