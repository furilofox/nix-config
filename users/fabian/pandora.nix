# User-specific configuration for home-manager

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./common
  ];

  # Specify State Version (match your NixOS version)
  home.stateVersion = "25.05";
}
