{config, ...}: {
  imports = [
    ./kitty.nix
    ./quickshell.nix
    ./firefox.nix
  ];

  firefox.enable = true;

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
