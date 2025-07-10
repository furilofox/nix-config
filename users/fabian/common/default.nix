# User-specific configuration for home-manager

{ config, pkgs, lib, ... }:

{
  imports = [
  ];

  home.packages = with pkgs; [
    # Development
    vscode
    git

    # Browser
    brave
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "fabian";
  home.homeDirectory = "/home/fabian";
}
