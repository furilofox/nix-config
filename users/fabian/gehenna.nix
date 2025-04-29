# User-specific configuration for home-manager

{ config, pkgs, unstable, lib, ... }:

{
  imports = [
    ./default.nix
  ];

  home.packages = with pkgs; [
    # Development
    vscode
    git
    
    # Browser - using unstable channel
    unstable.brave

    # Unsorted
    vim
    wget
    mission-center # Task / System Monitor
    gnome-extension-manager
    gparted

    gnome-tweaks
  ];

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}