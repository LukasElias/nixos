{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myNixos.services.cdemu = {
    enable = lib.mkEnableOption "cdemu";
  };

  config = lib.mkIf config.myNixos.services.cdemu.enable {
    boot.extraModulePackages = [ config.boot.kernelPackages.vhba ];
    boot.kernelModules = [ "vhba" "sg" ];

    environment.systemPackages = [
      pkgs.cdemu-client
      pkgs.cdemu-daemon
      pkgs.gcdemu
    ];

    services.dbus.packages = [ pkgs.cdemu-daemon ];

    # Allow user access to /dev/vhba_ctl
    services.udev.extraRules = ''
      KERNEL=="vhba_ctl", MODE="0660", GROUP="cdrom"
    '';

    users.users."${config.myNixos.users.name}".extraGroups = [ "cdrom" ];

    # Required for GNOME/dbus-broker: systemd --user unit
    systemd.user.services.cdemu-daemon = {
      description = "CDEmu Daemon";
      serviceConfig = {
        ExecStart = "${pkgs.cdemu-daemon}/bin/cdemu-daemon";
        Restart = "on-failure";
      };
    };
  };
}
