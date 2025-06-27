# modules/core/default.nix
# This file imports all core modules

{ config, lib, pkgs, ... }:

{
  imports = [
    ./gsconnect.nix
    ./git.nix
    ./1password.nix
  ];
}
