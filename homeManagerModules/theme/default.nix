{
  lib,
  config,
  ...
}: {
  imports = [
    ./colors.nix
    ./cursor.nix
    ./font.nix
    ./gtk.nix
    ./qt.nix
  ];

  options.myHomeManager.theme = {
    enable = lib.mkEnableOption "theme stuff";
  };

  config.myHomeManager.theme = lib.mkIf config.myHomeManager.theme.enable {
    cursor.enable = lib.mkDefault true;
    font.enable = lib.mkDefault true;
    gtk.enable = lib.mkDefault true;
    qt.enable = lib.mkDefault true;
  };
}
