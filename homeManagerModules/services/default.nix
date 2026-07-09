{
  config,
  lib,
  ...
}: {
  imports = [
    ./udiskie.nix
  ];

  options.myHomeManager.services = {
    enable = lib.mkEnableOption "hm-services";
  };

  config.myHomeManager.services = lib.mkIf config.myHomeManager.services.enable {
    udiskie.enable = lib.mkDefault true;
  };
}
