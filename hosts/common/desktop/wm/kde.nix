# modules/desktop/xserver.nix
# X Server and display manager configuration

{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    # Desktop environment
    desktopManager = {
      plasma6.enable = true;
    };

    # Configure keyboard
    xkb = {
      layout = "de";
      variant = "";
    };
  };

  services.displayManager.defaultSession = "plasma";
}
