# modules/core/networking.nix
# Shared networking configuration across systems

{ config, lib, pkgs, ... }:

{
  # Basic networking configuration
  networking = {
    firewall = {
      enable = true;
      # Common services to allow
      # allowedTCPPorts = [ 80 443 ];
      # allowedUDPPorts = [ 53 ];
    };

    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };

  # Enable OpenSSH server (uncomment if needed)
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     PasswordAuthentication = false;
  #     PermitRootLogin = "no";
  #   };
  # };

  # Enable TimeSync
  services.timesyncd.enable = true;
}
