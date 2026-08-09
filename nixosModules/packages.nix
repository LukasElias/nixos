{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./wrappers
  ];

  config = {
    myWrappers.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      wget
      git
      curl
      gcc
    ];

    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };
  };
}
