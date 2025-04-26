# Configuration for luna host
{ config, lib, pkgs, hostname, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Import parent hosts/default.nix
    ../default.nix

    # Import other hardware configuration    
    ./networking.nix

    # Import user configurations
    ../../users/fabian/luna.nix
    # Add other users for this host if needed
  ];

  # Set basic system configuration
  networking.hostName = hostname;
  

  # Basic bootloader configuration (customize as needed)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable basic services
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # User accounts
  users.users.fabian = {
    isNormalUser = true;
    description = "fabian";
    extraGroups = [ "wheel" "networkmanager" "libvirtd"];
    # For password-based login:
    # initialPassword = "changeme";
    # For SSH key-based login:
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA..." ];
  };



  system.stateVersion = "24.11"; # Do not change this after initial install
}