{
  config,
  lib,
  ...
}: let
  cfg = config.myWrappers.services;
in {
  options.myWrappers.services = {
    enable = lib.mkEnableOption "service wrappers";
  };

  imports = [
    ./hypridle.nix
  ];

  config.myWrappers.services = lib.mkIf cfg.enable {
    hypridle.enable = lib.mkDefault true;
  };
}
