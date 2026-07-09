{
  config,
  lib,
  ...
}: {
  options.myNixos.services.printing = {
    enable = lib.mkEnableOption "printing";
  };

  config = lib.mkIf config.myNixos.services.printing.enable {
    services.printing.enable = true;
  };
}
