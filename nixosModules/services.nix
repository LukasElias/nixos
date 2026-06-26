{pkgs, ...}: {
  services = {
    greetd = {
      enable = true;
      settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --cmd start-hyprland";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNER_ON_AC = "performance";
        CPU_SCALING_GOVERNER_ON_BAT = "powersave";
      };
    };
    upower.enable = true;
    blueman.enable = true;
    printing.enable = true;
    libinput.enable = true;
    xserver.xkb.layout = "dk";
    udisks2.enable = true;

    udev.extraRules = ''
      # Micro:bit / DAPLink debugger
      SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", MODE="0666", GROUP="plugdev"
    '';
  };
}
