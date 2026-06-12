{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../nixosModules
      inputs.home-manager.nixosModules.default
    ];

  nix = {
    settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "spotify"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.blacklistedKernelModules = [ "ideapad_laptop" ];

  networking.hostName = "LukasLaptop"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "da_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "dk";
    useXkbConfig = true; # use xkb.options in tty.
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          FastConnectable = true;
          Experimental = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.LukasElias = {
    isNormalUser = true;
    extraGroups = [ "wheel" "seat" "plugdev" ]; # Enable ‘sudo’ for the user.
  };

  users.groups.plugdev = {};

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    stow
    kitty
    starship 
    tree-sitter
    python315
    gh
    fuzzel
    spotify
    playerctl
    wlogout
    fastfetch
    quickshell
    unzip
    rustup
    yazi
    gcc
    brightnessctl
  ];

  environment.etc."systemd/system-sleep/i8042-fix.sh" = {
    text = ''
      #!/bin/sh
      case $1/$2 in
        pre/*)
          rmmod i8042
          ;;
        post/*)
          modprobe i8042 reset=1
          ;;
      esac
    '';
    mode = "0755";
  };

  services.udisks2.enable = true;

  services.udev.extraRules = ''
    # Micro:bit / DAPLink debugger
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", MODE="0666", GROUP="plugdev"
  '';

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "LukasElias" = import ./../../homeManagerModules;
    };
  };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

