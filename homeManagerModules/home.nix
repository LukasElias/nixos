{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.homeDirectory = "/home/${config.home.username}";

  home.packages = with pkgs; [
    fd
    ripgrep
    fuzzel
    stow
    fastfetch
    unzip
    libnotify
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
}
