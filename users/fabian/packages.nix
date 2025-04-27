# users/yourusername/packages.nix
# User-specific packages

{ config, pkgs, unstable, lib, ... }:

{
  # User-specific packages
  home.packages = with pkgs; [
    # Development
    vscode
    git
    
    # Tools
    htop
    ripgrep
    fd
    
    # Browser - using unstable channel
    unstable.firefox
    
    # Communication
    unstable.discord
    
    # Media
    vlc
    mpv
  ];
}