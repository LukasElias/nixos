{
  config,
  lib,
  ...
}: {
  imports = [
    ./bash.nix
    ./git.nix
    ./nvim.nix
    ./starship.nix
  ];

  options.myHomeManager.programs.terminal = {
    enable = lib.mkEnableOption "terminal programs";
  };

  config.myHomeManager.programs.terminal = lib.mkIf config.myHomeManager.programs.terminal.enable {
    git.enable = true;

    bash = {
      enable = true;
      enableColorAliases = true;
    };

    starship.enable = true;

    nvim.enable = true;
  };
}
