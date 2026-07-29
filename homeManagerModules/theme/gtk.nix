{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.myHomeManager.theme.gtk;
in {
  options.myHomeManager.theme.gtk = {
    enable = lib.mkEnableOption "gtk theme";
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Breeze-Dark";
        package = pkgs.kdePackages.breeze-gtk;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "lavender";
        };
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Breeze-Dark";
        color-scheme = "prefer-dark";
      };
    };
  };
}
