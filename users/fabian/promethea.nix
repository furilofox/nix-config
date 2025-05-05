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
    mission-center # Task / System Monitor
    gparted
    easyeffects
    nextcloud-client
    telegram-desktop
    obsidian

    protonup

    gnome-tweaks
    gnome-network-displays
  ];

  xdg.desktopEntries = {
    "org.kde.kdeconnect.sms" = {
      exec = "";
      name = "KDE Connect SMS";
      settings.NoDisplay = "true";
    };
    "org.kde.kdeconnect.nonplasma" = {
      exec = "";
      name = "KDE Connect Indicator";
      settings.NoDisplay = "true";
    };
    "org.kde.kdeconnect.app" = {
      exec = "";
      name = "KDE Connect";
      settings.NoDisplay = "true";
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}