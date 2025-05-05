# modules/core/default.nix
# This file imports all core modules

{ config, lib, pkgs, ... }:

{
  imports = [
    ./kdeconnect.nix
    ./git.nix
  ];
}
