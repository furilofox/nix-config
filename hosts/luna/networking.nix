# Networking configuration for luna
{ config, lib, pkgs, ... }:

{
  # Enable NetworkManager
  networking = {
    networkmanager.enable = true;

    nameservers = ["1.1.1.1" "8.8.8.8"];
    
    # Configure DHCP for most interfaces
    useDHCP = lib.mkDefault true;
    
    # Firewall configuration
    firewall = {
      enable = true;
      allowedTCPPorts = [ 
        # 22    # SSH
        # 80    # HTTP
        # 443   # HTTPS
      ];
      allowedUDPPorts = [ 
        # Add UDP ports here
      ];
    };
  };
}