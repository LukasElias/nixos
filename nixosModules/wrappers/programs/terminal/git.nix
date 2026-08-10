{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.myWrappers.programs.terminal.git;
in {
  options.myWrappers.programs.terminal.git = {
    enable = lib.mkEnableOption "git wrapper";
    wrapperPackage = lib.mkOption {
      type = lib.types.package;
      description = "wrapper package for git";
    };
    user = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "LukasElias";
            description = "git username";
          };
          email = lib.mkOption {
            type = lib.types.str;
            default = "lukaslundmajland@gmail.com";
            description = "git email";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    myWrappers.programs.terminal.git.wrapperPackage =
      (inputs.wrappers.wrapperModules.git.apply {
        inherit pkgs;
        settings = {
          inherit (cfg) user;
        };
      }).wrapper;
    environment.systemPackages = [
      cfg.wrapperPackage
    ];
  };
}
