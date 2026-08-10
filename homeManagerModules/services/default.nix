{
  config,
  lib,
  ...
}: {
  imports = [
    ./udiskie.nix
    ./hypridle.nix
  ];

  options.myHomeManager.services = {
    enable = lib.mkEnableOption "hm-services";
  };

  config.myHomeManager.services = lib.mkIf config.myHomeManager.services.enable {
    udiskie.enable = lib.mkDefault true;
    hypridle.enable = lib.mkDefault false;
  };
}
