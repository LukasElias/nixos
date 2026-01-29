{ config, lib, pkgs, ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNER_ON_AC = "performance";
      CPU_SCALING_GOVERNER_ON_BAT = "powersave";
    };
  };
  services.upower.enable = true;

  services.blueman.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.displayManager.ly.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.xserver.xkb.layout = "dk";
}
