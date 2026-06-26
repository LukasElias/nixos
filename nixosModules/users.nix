{inputs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.LukasElias = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "seat"
      "plugdev"
    ]; # Enable ‘sudo’ for the user.
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "LukasElias" = import ./../homeManagerModules;
    };
  };
}
