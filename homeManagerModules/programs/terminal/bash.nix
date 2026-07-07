{
  lib,
  config,
  ...
}: {
  options.bash = {
    enable = lib.mkEnableOption "bash";
    enableColorAliases = lib.mkEnableOption "bash color aliases";
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

  config = lib.mkIf config.bash.enable {
    programs.bash = {
      enable = true;
      historySize = config.bash.history.memorySize;
      historyFileSize = config.bash.history.fileSize;
      shellAliases = lib.mkIf config.bash.enableColorAliases {
        ls = "ls --color";
        grep = "grep --color";
      };
    };
  };
}
