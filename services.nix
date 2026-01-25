{ config, lib, pkgs, ... }:

{
  services.tlp.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.xserver.xkb.layout = "dk";
}
