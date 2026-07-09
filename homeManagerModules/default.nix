{lib, ...}: {
  imports = [
    ./home.nix
    ./theme
    ./services
    ./programs/graphical
    ./programs/terminal
    ./windowManagers
  ];

  myHomeManager = {
    programs.graphical.enable = lib.mkDefault true;
    programs.terminal.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
    services.enable = lib.mkDefault true;
    windowManagers.enable = lib.mkDefault true;
  };
}
