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

    cheese
  ];

  # Set Right Click to be Mousepad Bottom right instead of 2 Finger Click
  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "areas";
    };
  };

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}
