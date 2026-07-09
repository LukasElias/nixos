{
  config,
  lib,
  ...
}: {
  options.myNixos.hardware.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf config.myNixos.hardware.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          FastConnectable = true;
          Experimental = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };
}
