{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.myWrappers.programs.graphical.kitty;
in {
  options.myWrappers.programs.graphical.kitty = {
    enable = lib.mkEnableOption "kitty wrapper";
    finalPackage = lib.mkOption {
      type = lib.types.package;
      description = "The final wrapper package for kitty";
      readOnly = true;
    };
  };

  config = lib.mkIf cfg.enable {
    myWrappers.programs.graphical.kitty.finalPackage =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        settings = {
          enable_audio_bell = false;
          scrollback_lines = 1000;
          tab_bar_align = "center";
          background_opacity = 0.95;
        };
      }).wrapper;
    environment.systemPackages = [
      cfg.finalPackage
    ];
  };
}
