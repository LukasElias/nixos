{config, ...}: {
  imports = [
    ./kitty.nix
    ./quickshell.nix
  ];

  quickshell = {
    enable = true;
    font.name = config.myFont.defaultFonts.monospace.family;
  };

  kitty = {
    enable = true;
    font = {
      name = config.myFont.defaultFonts.monospace.family;
      package = config.myFont.defaultFonts.monospace.package;
    };
  };
}
