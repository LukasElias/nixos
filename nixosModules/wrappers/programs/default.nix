{
  config,
  lib,
  ...
}: let
  cfg = config.myWrappers.programs;
in {
  options.myWrappers.programs = {
    enable = lib.mkEnableOption "program wrappers";
  };

  imports = [
    ./graphical
    ./terminal
  ];

  config.myWrappers.programs = lib.mkIf cfg.enable {
    graphical.enable = lib.mkDefault true;
    terminal.enable = lib.mkDefault true;
  };
}
