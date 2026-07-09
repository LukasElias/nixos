{
  config,
  lib,
  ...
}: {
  imports = [
    ./kitty.nix
    ./quickshell.nix
    ./firefox.nix
  ];

  options.myHomeManager.programs.graphical = {
    enable = lib.mkEnableOption "graphical programs";
  };

  config.myHomeManager.programs.graphical = lib.mkIf config.myHomeManager.programs.graphical.enable {
    firefox.enable = lib.mkDefault true;

    quickshell = {
      enable = lib.mkDefault true;
      font.name = config.myHomeManager.theme.font.defaultFonts.monospace.family;
    };

    kitty = {
      enable = lib.mkDefault true;
      font = {
        name = config.myHomeManager.theme.font.defaultFonts.monospace.family;
        package = config.myHomeManager.theme.font.defaultFonts.monospace.package;
      };
    };
  };
}
