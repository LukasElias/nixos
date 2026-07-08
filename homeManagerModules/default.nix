{...}: {
  imports = [
    ./font.nix
    ./home.nix
    ./hyprland.nix
    ./programs/graphical
    ./programs/terminal
  ];

  myHomeManager.programs.graphical.enable = true;
  myHomeManager.programs.terminal.enable = true;
}
