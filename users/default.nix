# Common user configuration
{ config, lib, pkgs, ... }:

{
  # Common user settings go here
  imports = [
    ../modules/home-manager/default.nix  # Import common user config
  ];
}