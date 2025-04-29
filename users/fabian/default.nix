# User-specific configuration for home-manager

{ config, pkgs, unstable, lib, ... }:

{
  imports = [

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

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}