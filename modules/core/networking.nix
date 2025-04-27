# modules/core/networking.nix
# Shared networking configuration across systems

{ config, lib, pkgs, ... }:

{
  # Basic networking configuration
  networking = {
    # Enable NetworkManager for most desktop systems
    networkmanager = {
      enable = true;
      # Wifi power saving
      wifi.powersave = true;
    };
    
    # Firewall configuration
    firewall = {
      enable = true;
      allowPing = true;
      # Common services to allow
      # allowedTCPPorts = [ 80 443 ];
      # allowedUDPPorts = [ 53 ];
    };
    
    # Disable IPv6 if not needed
    # enableIPv6 = false;
    
    # Set DNS servers (if not using DHCP)
    # nameservers = [ "1.1.1.1" "8.8.8.8" ];
    
    # Hosts file entries
    # hosts = {
    #   "127.0.0.1" = [ "localhost" "local.dev" ];
    #   "192.168.1.2" = [ "nas" ];
    # };
  };

  # Enable OpenSSH server (uncomment if needed)
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     PasswordAuthentication = false;
  #     PermitRootLogin = "no";
  #   };
  # };

  # Enable avahi/mDNS for local network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      workstation = true;
    };
  };
  
  # Enable TimeSync
  services.timesyncd.enable = true;
}