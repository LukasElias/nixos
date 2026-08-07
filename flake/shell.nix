{
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nil
        lua-language-server
        kdePackages.qtdeclarative
      ];
    };
  };
}
