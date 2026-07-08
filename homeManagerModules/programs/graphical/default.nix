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
    firefox.enable = true;

    quickshell = {
      enable = true;
      font.name = config.myHomeManager.font.defaultFonts.monospace.family;
    };

    kitty = {
      enable = true;
      font = {
        name = config.myHomeManager.font.defaultFonts.monospace.family;
        package = config.myHomeManager.font.defaultFonts.monospace.package;
      };
    };
  };
}
