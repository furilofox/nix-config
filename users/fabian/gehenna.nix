# User-specific configuration for home-manager

{ config, pkgs, lib, ... }:

{
  imports = [
    ./default.nix
  ];

  home.packages = with pkgs; [
    # Development
    vscode
    git

    # Browser
    brave

    # Unsorted
    wget
    mission-center # Task / System Monitor

    gnome-tweaks
  ];

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}
