{lib, ...}: {
  imports = [
    ./hardware
    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./services
    ./users.nix
  ];

  myNixos = {
    services.enable = lib.mkDefault true;
    hardware.enable = lib.mkDefault true;
    users.enable = lib.mkDefault true;
  };
}
