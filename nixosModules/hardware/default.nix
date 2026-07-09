{config, lib, ...}: {
  imports = [
    ./bluetooth.nix
    ./graphics.nix
  ];

  options.myNixos.hardware = {
    enable = lib.mkEnableOption "hardware drivers";
  };

  config.myNixos.hardware = lib.mkIf config.myNixos.hardware.enable {
    graphics.enable = lib.mkDefault true;
    bluetooth.enable = lib.mkDefault true;
  };
}
