{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "LukasElias";
  home.homeDirectory = "/home/${config.home.username}";

  home.packages = with pkgs; [
    fd
    ripgrep
    fuzzel
    stow
    spotify
    playerctl
    wlogout
    fastfetch
    unzip
    yazi
    brightnessctl
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];
}
