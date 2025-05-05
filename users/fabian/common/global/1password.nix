# modules/core/default.nix
# This file imports all core modules

{ config, lib, unstable, pkgs, ... }:

{
  home.packages = [
    unstable._1password
    unstable._1password-gui
  ];
}
