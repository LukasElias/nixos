{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    configs = {
      default = ../config/quickshell;
    };
  };
}
