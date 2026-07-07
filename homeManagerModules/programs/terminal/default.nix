{...}: {
  imports = [
    ./bash.nix
    ./git.nix
    ./nvim.nix
    ./starship.nix
  ];

  git.enable = true;

  bash = {
    enable = true;
    enableColorAliases = true;
  };

  starship.enable = true;

  nvim.enable = true;
}
