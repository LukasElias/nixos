{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.quickshell = {
    enable = true;
    systemd.enable = false;
    configs = {
      default = ../config/quickshell;
    };
  };
}
