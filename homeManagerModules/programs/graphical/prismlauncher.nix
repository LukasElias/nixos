{
  config,
  lib,
  ...
}: {
  options.myHomeManager.programs.graphical.prismlauncher = {
    enable = lib.mkEnableOption "prism launcher";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.prismlauncher.enable {
    programs.prismlauncher = {
      enable = true;
    };
  };
}
