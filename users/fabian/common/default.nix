# User-specific configuration for home-manager

{ config, pkgs, pkgs-stable, lib, ... }:

{
  imports = [
    ./global
    # ./programs/hyprland
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "fabian";
  home.homeDirectory = "/home/fabian";

  home.packages = (with pkgs; [
    fastfetch

    kdePackages.dolphin # File Manager
    kdePackages.qtsvg # To support svg icons
    kdePackages.kio-fuse # To mount remote filesystems via FUSE
    kdePackages.kio-extras # Extra protocols support (sftp, fish and more)
  ])

  ++

  (with pkgs-stable; [

    # For easy dev shells
    devenv # Broken on Unstable rn
  ]);

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}
