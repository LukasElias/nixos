{
  config,
  lib,
  ...
}: {
  options.myHomeManager.services.udiskie = {
    enable = lib.mkEnableOption "udiskie";
  };

  config = lib.mkIf config.myHomeManager.services.udiskie.enable {
    services.udiskie = {
      enable = true;
      # settings = {
      #   program_options = {
      #     file_manager = "${pkgs.kitty}/bin/kitty ${pkgs.yazi}/bin/yazi";
      #   };
      # };
    };
  };
}
