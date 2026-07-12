{
  config,
  lib,
  ...
}: {
  options.myNixos.pam = {
    enable = lib.mkEnableOption "pam services";
  };

  config = lib.mkIf config.myNixos.pam.enable {
    security.pam.services.hyprlock.enable = true;
    security.pam.services.swaylock.enable = false;
  };
}
