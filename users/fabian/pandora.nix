# User-specific configuration for home-manager

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./common/default.nix
  ];

  home.packages = with pkgs; [
    # Development
    vscode
    git

    # Browser
    inputs.zen-browser.packages."${system}".specific

    # Communication
    vesktop
    discord

    # Unsorted
    vim
    wget
    mangohud # Game Hardware stats
    protonup # "protonup" in terminal to download proton-ge
    lutris # great game launcher
    heroic # good for epicgames
    bottles # windows app container
    mission-center # Task / System Monitor
    gnome-extension-manager
    gparted
    easyeffects
    nextcloud-client
    telegram-desktop
    obsidian

    (prismlauncher.override {
      # Add binary required by some mod
      additionalPrograms = [ ffmpeg ];

      # Change Java runtimes available to Prism Launcher
      jdks = [
        graalvm-ce
        zulu8
        zulu17
        zulu
      ];
    })

    gnome-tweaks

    glmark2
    stress
    gnome-logs

    bambu-studio
  ];

  # Specify State Version (match your NixOS version)
  home.stateVersion = "25.05";
}
