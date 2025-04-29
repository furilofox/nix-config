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

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "fabian";
  home.homeDirectory = "/home/fabian";

  # Configure Git
  programs.git = {
    enable = true;
    userName = "Furilo";
    userEmail = "53122773+furilofox@users.noreply.github.com";
  };

  # Configure shell (e.g., zsh with oh-my-zsh)
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "docker" "sudo" ];
    };
  };

  # Configure your preferred editor
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}