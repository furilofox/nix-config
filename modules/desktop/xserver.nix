# modules/desktop/xserver.nix
# X Server and display manager configuration

{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver = {
    enable = true;
    
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
      
      
    };
    
    # Desktop environment
    desktopManager = {
      gnome.enable = true;
    };
    
    # Configure keyboard
    xkb = {
        layout = "de";
        variant = "";
    };

    videoDrivers = ["nvidia"];
  };

  services.displayManager.defaultSession = "gnome";

  # Force Wayland for other Apps
  environment.sessionVariables = {
    # Force Wayland for Chromium based applications
    NIXOS_OZONE_WL = "1";
    # Force Wayland for vscode
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    # Force Wayland for firefox
    MOZ_ENABLE_WAYLAND = 1;
  };
}