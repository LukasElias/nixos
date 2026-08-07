{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;
  hosts = lib.attrNames (lib.readDir ../hosts);
in {
  flake.nixosConfigurations = lib.genAttrs hosts (
    hostname:
      lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ../hosts/${hostname}/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      }
  );
}
