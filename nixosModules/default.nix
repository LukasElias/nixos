{...}: {
  imports = [
    ./hardware.nix
    ./nix.nix
    ./packages.nix
    ./services.nix
    ./users.nix
  ];
}
