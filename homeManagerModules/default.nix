{...}: {
  imports = [
    ./home.nix
    ./hyprland.nix
    ./theme
    ./programs/graphical
    ./programs/terminal
  ];

  myHomeManager.programs.graphical.enable = true;
  myHomeManager.programs.terminal.enable = true;
  myHomeManager.theme.enable = true;
}
