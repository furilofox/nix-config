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

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

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

  # Desktop Manager
  services = {
    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "de";
        variant = "";
      };
      # Force Wayland
      displayManager.gdm.wayland = true;
    };
  };

  # Force Wayland everywhere
  environment.sessionVariables = {
    # Force Wayland for Chromium based applications
    NIXOS_OZONE_WL = "1";
    # Force Wayland for vscode
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    # Force Wayland for firefox
    MOZ_ENABLE_WAYLAND = 1;
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Open GL
  hardware.graphics = {
    enable = true;
  };

  # Enable Printing
  services.printing.enable = true;

  # Enable NVIDIA Stuff
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false; # You can enable this if you wish to experiment, but start with it off for troubleshooting
    powerManagement.finegrained = false; # Requires powerManagement.enable = true
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


  system.stateVersion = "24.11"; # Do not change this after initial install
}