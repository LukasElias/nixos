{
  config,
  lib,
  ...
}: let
  cfg = config.myWrappers;
in {
  options.myWrappers = {
    enable = lib.mkEnableOption "wrappers";
  };

  imports = [
    ./programs
    ./services
  ];

  config.myWrappers = lib.mkIf cfg.enable {
    programs.enable = lib.mkDefault true;
    services.enable = lib.mkDefault true;
  };
}
