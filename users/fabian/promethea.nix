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

    # Communication
    vesktop

    # Unsorted
    wget
    bottles # windows app container
    mission-center # Task / System Monitor
    gparted
    easyeffects
    nextcloud-client
    telegram-desktop
    obsidian

    protonup

    gnome-tweaks
    gnome-network-displays

    bruno

    realvnc-vnc-viewer
  ];

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}
