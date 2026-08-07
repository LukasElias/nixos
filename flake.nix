{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sysc-greet = {
      url = "github:Nomadcxx/sysc-greet";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      perSystem = {pkgs, ...}: {
        treefmt.programs = {
          alejandra.enable = true;
          stylua.enable = true;
          qmlformat.enable = true;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nil
            lua-language-server
            kdePackages.qtdeclarative
          ];
        };
      };
      flake = {lib, ...}: {
        nixosConfigurations = {
          LukasLaptop = lib.nixosSystem {
            specialArgs = {inherit inputs;};
            modules = [
              ./hosts/LukasLaptop/configuration.nix
              inputs.home-manager.nixosModules.default
            ];
          };
          LukasPC = lib.nixosSystem {
            specialArgs = {inherit inputs;};
            modules = [
              ./hosts/LukasPC/configuration.nix
              inputs.home-manager.nixosModules.default
            ];
          };
        };
      };
    };
}
