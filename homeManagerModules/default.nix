{ config, lib, pkgs, ... }:

{
  imports = [
    ./home.nix
    ./hyprland.nix
	./kitty.nix
  ];
}
