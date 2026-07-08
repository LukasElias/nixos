{
  lib,
  config,
  ...
}: {
  options.myHomeManager.programs.terminal.bash = {
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

  config = lib.mkIf config.myHomeManager.programs.terminal.bash.enable {
    programs.bash = {
      enable = true;
      historySize = config.myHomeManager.programs.terminal.bash.history.memorySize;
      historyFileSize = config.myHomeManager.programs.terminal.bash.history.fileSize;
      shellAliases = lib.mkIf config.myHomeManager.programs.terminal.bash.enableColorAliases {
        ls = "ls --color";
        grep = "grep --color";
      };
    };
  };
}
