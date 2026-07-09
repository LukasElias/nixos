{
  config,
  lib,
  ...
}: {
  options.myNixos.services.libinput = {
    enable = lib.mkEnableOption "libinput";
  };

  config = lib.mkIf config.myNixos.services.libinput.enable {
    services.libinput.enable = true;
  };
}
