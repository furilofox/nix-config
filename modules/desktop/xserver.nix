# modules/desktop/xserver.nix
# X Server and display manager configuration

{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver = {
    enable = true;
    
    # Configure display manager (login screen)
    displayManager = {
      # Use SDDM, GDM, or LightDM as needed 
      gdm = {
        enable = true;
        wayland = true;
      };
      
      # Default session to start
      defaultSession = "gnome";
      
      # Auto-login if desired
      # autoLogin = {
      #   enable = true;
      #   user = "yourusername";
      # };
    };
    
    # Desktop environment
    # Choose one or more as needed
    desktopManager = {
      gnome.enable = true;
      # plasma5.enable = true;
      # xfce.enable = true;
    };
    
    # Window manager
    # Choose one if needed
    windowManager = {
      # i3.enable = true;
      # bspwm.enable = true;
      # awesomewm.enable = true;
    };
    
    # Configure keyboard
    xkb = {
      layout = "us";
      # variant = "altgr-intl"; # For international layout
      # options = "eurosign:e,caps:escape"; # Custom options
    };
    
    # Configure libinput for touchpad
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        middleEmulation = true;
        disableWhileTyping = true;
      };
    };
    
    # Enable touchscreen support if needed
    # wacom.enable = true;
  };
  
  # Enable Wayland with GNOME
  services.xserver.displayManager.gdm.wayland = true;
  
  # Configure screen locker
  services.xserver.xautolock = {
    enable = true;
    time = 10; # Lock after 10 minutes
    locker = "${pkgs.i3lock}/bin/i3lock -i /path/to/lockscreen.png";
    # Other options
    killtime = 20; # Turn off screen after 20 minutes
    killer = "${pkgs.systemd}/bin/systemctl suspend";
  };
  
  # Configure redshift for blue light reduction
  services.redshift = {
    enable = true;
    temperature = {
      day = 5700;
      night = 3500;
    };
    latitude = "40.0";  # Replace with your latitude
    longitude = "-70.0"; # Replace with your longitude
  };
}