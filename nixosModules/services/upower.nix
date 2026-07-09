{
  config,
  lib,
  ...
}: {
  options.myNixos.services.upower = {
    enable = lib.mkEnableOption "upower";
  };

  config = lib.mkIf config.myNixos.services.upower.enable {
    services.upower.enable = true;
  };
}
