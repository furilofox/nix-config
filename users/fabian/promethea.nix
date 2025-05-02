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
    
    # Communication
    vesktop

    # Unsorted
    vim
    wget
    bottles # windows app container
    unstable._1password-gui # 1Password Desktop
    mission-center # Task / System Monitor
    gparted
    easyeffects
    nextcloud-client
    telegram-desktop
    obsidian

    gnome-tweaks
  ];

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}