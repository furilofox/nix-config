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
      
      defaultSession = "gnome";
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
  
  # Configure screen locker
  services.xserver.xautolock = {
    enable = true;
    time = 30; # Lock after 10 minutes
    #locker = "${pkgs.i3lock}/bin/i3lock -i /path/to/lockscreen.png";
    # Other options
    killtime = 20; # Turn off screen after 20 minutes
    killer = "${pkgs.systemd}/bin/systemctl suspend";
  };
}