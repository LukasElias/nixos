{
  config,
  lib,
  ...
}: {
  options.myNixos.services.blueman = {
    enable = lib.mkEnableOption "blueman";
  };

  config = lib.mkIf config.myNixos.services.blueman.enable {
    services.blueman.enable = true;
  };
}
