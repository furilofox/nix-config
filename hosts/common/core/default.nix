# modules/core/default.nix
# This file imports all core modules

{ config, lib, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./networking.nix
    ./formatting.nix
    ./locale.nix
    ./1password.nix
  ];
}
