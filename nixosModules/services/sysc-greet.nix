{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.myNixos.services.sysc-greet;
in {
  imports = [
    inputs.sysc-greet.nixosModules.default
  ];

  options.myNixos.services.sysc-greet = {
    enable = lib.mkEnableOption "sysc greet";
  };

  config = lib.mkIf cfg.enable {
    services.sysc-greet = {
      enable = true;
      compositor = "cagebreak";
      cagebreakPackage = pkgs.cagebreak;
    };
  };
}
