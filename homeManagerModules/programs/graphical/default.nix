{ pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./quickshell.nix
  ];

  quickshell = {
    enable = true;
    font.name = "AgaveNerdFont";
  };

  kitty = {
    enable = true;
    font = {
      name = "AgaveNerdFont";
      package = pkgs.nerd-fonts.agave;
    };
  };
}
