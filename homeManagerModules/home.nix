{
  config,
  inputs,
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
  home.homeDirectory = "/home/LukasElias";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.agave
    fd
    ripgrep
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  dconf.settings = {
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "LukasElias";
      user.email = "lukaslundmajland@gmail.com";
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  programs.gh.enable = true;

  programs.bash = {
    enable = true;
    historySize = 1000;
    historyFileSize = 10000;
    shellAliases = {
      ls = "ls --color";
      grep = "grep --color";
    };
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        file_manager = "${pkgs.kitty}/bin/kitty ${pkgs.yazi}/bin/yazi";
      };
    };
  };

  programs.home-manager.enable = true;
}
