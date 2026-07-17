{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHomeManager.programs.graphical.synologyDriveClient = {
    enable = lib.mkEnableOption "synology-drive-client";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.synologyDriveClient.enable {
    home.packages = with pkgs; [
      synology-drive-client
    ];
  };
}
