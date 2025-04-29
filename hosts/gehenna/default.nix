# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, unstable, lib, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan
      ./hardware-configuration.nix


      # Import modules
      ../../modules/core
      ../../modules/desktop
    ];

  # Hostname / Network
  networking.hostName = "gehenna"; # Define your hostname

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # User
  users.users.fabian = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
  ];

  # System version
  system.stateVersion = "24.11";
}