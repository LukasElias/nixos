{
  pkgs,
  inputs,
  lib,
  ...
}: {
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
    hyprshutdown
  ];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "spotify"
    ];
}
