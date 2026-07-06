{
  lib,
  config,
  ...
}:

{
  options.git = {
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

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user.name = config.git.name;
        user.email = config.git.email;
      };
    };
  };
}
