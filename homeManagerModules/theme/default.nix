{
  lib,
  config,
  ...
}: {
  imports = [
    ./font.nix
    ./gtk.nix
    ./qt.nix
  ];

  options.myHomeManager.theme = {
    enable = lib.mkEnableOption "theme stuff";
  };

  config.myHomeManager.theme = lib.mkIf config.myHomeManager.theme.enable {
    font.enable = lib.mkDefault true;
    gtk.enable = lib.mkDefault true;
    qt.enable = lib.mkDefault true;
  };
}
