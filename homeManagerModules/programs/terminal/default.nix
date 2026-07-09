{
  config,
  lib,
  ...
}: {
  imports = [
    ./bash.nix
    ./dircolors.nix
    ./gh.nix
    ./git.nix
    ./nvim.nix
    ./starship.nix
  ];

  options.myHomeManager.programs.terminal = {
    enable = lib.mkEnableOption "terminal programs";
  };

  config.myHomeManager.programs.terminal = lib.mkIf config.myHomeManager.programs.terminal.enable {
    bash = {
      enable = lib.mkDefault true;
      enableColorAliases = lib.mkDefault true;
    };

    dircolors.enable = lib.mkDefault true;

    gh.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;

    nvim.enable = lib.mkDefault true;

    starship.enable = lib.mkDefault true;
  };
}
