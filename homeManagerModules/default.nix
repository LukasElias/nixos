{lib, ...}: {
  imports = [
    ./home.nix
    ./hyprland.nix
    ./theme
    ./services
    ./programs/graphical
    ./programs/terminal
  ];

  myHomeManager.programs.graphical.enable = lib.mkDefault true;
  myHomeManager.programs.terminal.enable = lib.mkDefault true;
  myHomeManager.theme.enable = lib.mkDefault true;
  myHomeManager.services.enable = lib.mkDefault true;
}
