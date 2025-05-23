# User-specific configuration for home-manager

{ config, pkgs, lib, ... }:

{
  imports = [
    ./common/global
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "fabian";
  home.homeDirectory = "/home/fabian";

  home.packages = with pkgs; [

    # For easy dev shells
    devenv

    fastfetch

  ];

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}
