# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, unstable, lib, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan
      ./hardware-configuration.nix
    ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "hostname1"; # Define your hostname

  # Network configuration
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin"; # Adjust to your time zone

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Desktop Environment (e.g., GNOME)
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Define a user account
  users.users.yourusername = {
    isNormalUser = true;
    description = "Your Name";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    unstable.brave # Example of using unstable package
  ];

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # System version
  system.stateVersion = "24.11";
}