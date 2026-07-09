{
  config,
  lib,
  ...
}: {
  options.myNixos.services.tlp = {
    enable = lib.mkEnableOption "tlp";
  };

  config = lib.mkIf config.myNixos.services.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNER_ON_AC = "performance";
        CPU_SCALING_GOVERNER_ON_BAT = "powersave";
      };
    };
  };
}
