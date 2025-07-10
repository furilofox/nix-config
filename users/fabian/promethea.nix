# User-specific configuration for home-manager

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./common
  ];

  # Set Right Click to be Mousepad Bottom right instead of 2 Finger Click
  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "areas";
    };
  };

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}
