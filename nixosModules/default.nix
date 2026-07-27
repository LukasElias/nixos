{lib, ...}: {
  imports = [
    ./hardware
    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./services
    ./pam.nix
    ./users.nix
    ./smb.nix
  ];

  myNixos = {
    services.enable = lib.mkDefault true;
    hardware.enable = lib.mkDefault true;
    users.enable = lib.mkDefault true;
    pam.enable = lib.mkDefault true;
    smb.enable = lib.mkDefault true;
  };
}
