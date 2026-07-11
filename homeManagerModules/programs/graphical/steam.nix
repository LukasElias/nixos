{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHomeManager.programs.graphical.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.steam.enable {
    home.packages = with pkgs; [
      steam
    ];
  };
}
