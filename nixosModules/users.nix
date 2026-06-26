{inputs, ...}: {
  users.users.LukasElias = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "seat"
      "plugdev"
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "LukasElias" = import ./../homeManagerModules;
    };
  };
}
