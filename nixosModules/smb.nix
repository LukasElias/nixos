{
  config,
  lib,
  ...
}: let
  cfg = config.myNixos.smb;
in {
  options.myNixos.smb = {
    enable = lib.mkEnableOption "samba";
    mountPath = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/smb";
    };
    deviceName = lib.mkOption {
      type = lib.types.str;
      default = "//192.168.1.50/video";
    };
    credentialPath = lib.mkOption {
      type = lib.types.str;
      default = "/etc/smb-secrets";
    };
    automountOpts = lib.mkOption {
      type = lib.types.str;
      default = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    };
  };

  config = lib.mkIf cfg.enable {
    fileSystems."${cfg.mountPath}" = {
      device = cfg.deviceName;
      fsType = "cifs";
      options = ["${cfg.automountOpts},credentials=${cfg.credentialPath}"];
    };
  };
}
