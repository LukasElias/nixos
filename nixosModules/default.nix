{lib, ...}: {
  imports = [
    ./hardware.nix
    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./services
    ./users.nix
  ];

  myNixos.services.enable = lib.mkDefault true;
}
