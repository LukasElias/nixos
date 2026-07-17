{
  config,
  lib,
  ...
}: {
  options.myHomeManager.programs.graphical.keepassxc = {
    enable = lib.mkEnableOption "keepassxc";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.keepassxc.enable {
    programs.keepassxc = {
      enable = true;
    };
  };
}
