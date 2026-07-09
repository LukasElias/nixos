{
  config,
  lib,
  ...
}: {
  options.myNixos.hardware.graphics = {
    enable = lib.mkEnableOption "graphics";
  };

  config = lib.mkIf config.myNixos.hardware.graphics.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
