{
  lib,
  config,
  ...
}: let
  cfg = config.myHomeManager.programs.terminal.bash;
in {
  options.myHomeManager.programs.terminal.bash = {
    enable = lib.mkEnableOption "bash";
    aliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        ls = "ls --color";
        grep = "grep --color";
        h = "help";
      };
    };
    history = lib.mkOption {
      type = lib.types.submodule {
        options = {
          memorySize = lib.mkOption {
            type = lib.types.int;
            default = 1000;
            description = "amount of lines to keep in memory";
          };
          fileSize = lib.mkOption {
            type = lib.types.int;
            default = 10000;
            description = "amount of lines to keep on file";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      historySize = cfg.history.memorySize;
      historyFileSize = cfg.history.fileSize;
      shellAliases = cfg.aliases;
    };
  };
}
