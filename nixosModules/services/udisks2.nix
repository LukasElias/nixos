{
  config,
  lib,
  ...
}: {
  options.myNixos.services.udisks2 = {
    enable = lib.mkEnableOption "udisks2";
  };

  config = lib.mkIf config.myNixos.services.udisks2.enable {
    services.udisks2.enable = true;
  };
}
