{
  config,
  lib,
  ...
}: {
  options.myNixos.services.pipewire = {
    enable = lib.mkEnableOption "pipewire";
  };

  config = lib.mkIf config.myNixos.services.pipewire.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
