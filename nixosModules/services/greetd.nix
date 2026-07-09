{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myNixos.services.greetd = {
    enable = lib.mkEnableOption "greetd";
  };

  config = lib.mkIf config.myNixos.services.greetd.enable {
    services.greetd = {
      enable = true;
      settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --cmd start-hyprland";
    };
  };
}
