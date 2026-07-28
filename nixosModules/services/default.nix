{
  config,
  lib,
  ...
}: {
  imports = [
    ./blueman.nix
    ./sysc-greet.nix
    ./libinput.nix
    ./pipewire.nix
    ./printing.nix
    ./tlp.nix
    ./udisks2.nix
    ./upower.nix
  ];

  options.myNixos.services = {
    enable = lib.mkEnableOption "nixos services";
  };

  config.myNixos.services = lib.mkIf config.myNixos.services.enable {
    blueman.enable = lib.mkDefault true;
    sysc-greet.enable = lib.mkDefault true;
    libinput.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    printing.enable = lib.mkDefault true;
    tlp.enable = lib.mkDefault true;
    udisks2.enable = lib.mkDefault true;
    upower.enable = lib.mkDefault true;
  };
}
