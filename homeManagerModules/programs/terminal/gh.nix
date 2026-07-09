{
  config,
  lib,
  ...
}: {
  options.myHomeManager.programs.terminal.gh = {
    enable = lib.mkEnableOption "github cli";
  };

  config = lib.mkIf config.myHomeManager.programs.terminal.gh.enable {
    programs.gh.enable = true;
  };
}
