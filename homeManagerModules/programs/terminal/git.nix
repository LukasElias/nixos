{
  lib,
  config,
  ...
}: {
  options.myHomeManager.programs.terminal.git = {
    enable = lib.mkEnableOption "git";
    name = lib.mkOption {
      type = lib.types.str;
      default = "LukasElias";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "lukaslundmajland@gmail.com";
    };
  };

  config = lib.mkIf config.myHomeManager.programs.terminal.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user.name = config.myHomeManager.programs.terminal.git.name;
        user.email = config.myHomeManager.programs.terminal.git.email;
      };
    };
  };
}
