{
  config,
  lib,
  ...
}: {
  imports = [
    ./hyprland.nix
  ];

  options.myHomeManager.windowManagers = {
    enable = lib.mkEnableOption "window managers / desktop environments";
  };

  config.myHomeManager.windowManagers = lib.mkIf config.myHomeManager.windowManagers.enable {
    hyprland.enable = lib.mkDefault true;
  };
}
