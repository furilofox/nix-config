# User-specific configuration for home-manager

{ config, pkgs, unstable, lib, ... }:

{
  imports = [
    ./default.nix
  ];

  home.packages = with pkgs; [
    # Development
    unstable.vscode
    git

    # Browser - using unstable channel
    unstable.brave

    # Unsorted
    wget
    mission-center # Task / System Monitor

    gnome-tweaks
  ];

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}
