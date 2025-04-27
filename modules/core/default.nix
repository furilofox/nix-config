# modules/core/default.nix
# This file imports all core modules

{ config, lib, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./users.nix
    ./networking.nix
    ./formatting.nix
  ];
}