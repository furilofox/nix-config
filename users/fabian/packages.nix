# User-specific packages

{ config, pkgs, unstable, lib, ... }:

{
  # User-specific packages
  # 'unstable.<package>' to use unstable
  home.packages = with pkgs; [
    # Development
    vscode
    git
    
    # Tools
    htop
    ripgrep
    fd
    
    # Browser - using unstable channel
    unstable.brave
    
    # Communication
    vesktop
    
    # Media
    vlc
    mpv

    # Unsorted
    vim
    wget
    mangohud # Game Hardware stats
    protonup # "protonup" in terminal to download proton-ge
    lutris # great game launcher
    heroic # good for epicgames
    bottles # windows app container
    unstable._1password-gui # 1Password Desktop
    mission-center # Task / System Monitor
    gnome-extension-manager
    gparted
    easyeffects
    nextcloud-client
    telegram-desktop
    obsidian

    (prismlauncher.override {
      # Add binary required by some mod
      additionalPrograms = [ffmpeg];

      # Change Java runtimes available to Prism Launcher
      jdks = [
        graalvm-ce
        zulu8
        zulu17
        zulu
      ];
    })

    gnome-tweaks
  ];
}