{
  config,
  lib,
  inputs,
  ...
}: {
  options.myNixos.users = {
    enable = lib.mkEnableOption "user & homeManager setup";
    name = lib.mkOption {
      type = lib.types.str;
      default = "LukasElias";
    };
  };

  config = lib.mkIf config.myNixos.users.enable {
    users.users."${config.myNixos.users.name}" = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "seat"
        "plugdev"
      ];
    };

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users."${config.myNixos.users.name}" = {
        imports = [
          ./../homeManagerModules
        ];

        home.username = config.myNixos.users.name;
      };
    };
  };
}
