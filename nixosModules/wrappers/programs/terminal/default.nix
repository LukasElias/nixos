{
  config,
  lib,
  ...
}: let
  cfg = config.myWrappers.programs.terminal;
in {
  options.myWrappers.programs.terminal = {
    enable = lib.mkEnableOption "terminal program wrappers";
  };

  imports = [
    ./git.nix
  ];

  config.myWrappers.programs.terminal = lib.mkIf cfg.enable {
    git.enable = lib.mkDefault true;
  };
}
