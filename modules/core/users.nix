# modules/core/users.nix
# Shared user account configurations across systems

{ config, lib, pkgs, ... }:

{
  # Default user configuration settings
  users = {
    # Default shell for all users
    defaultUserShell = pkgs.zsh;
    
    # Don't allow mutation of users outside of Nix configuration
    mutableUsers = false;
    
    # Define user accounts that should exist on all systems
    # These can be overridden or extended in host-specific configs
    users = {
      # Root account
      root = {
        hashedPassword = null; # Disable root login
      };
      
      # Example user (this would normally be defined per-host)
      # Uncomment and customize as needed
      /*
      yourusername = {
        isNormalUser = true;
        description = "Your Full Name";
        extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
        # Generate password hash with: mkpasswd -m sha-512
        hashedPassword = "YOUR_HASHED_PASSWORD_HERE";
        # Or use passwordFile for more security
        # passwordFile = "/path/to/password/file";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... your-key-comment"
        ];
      };
      */
    };
  };

  # Configure sudo settings
  security.sudo = {
    enable = true;
    # Allow wheel group to use sudo without password
    # Consider security implications before enabling
    # wheelNeedsPassword = false;
    
    # Extra sudo rules if needed
    extraRules = [
      # Example: allow members of network group to restart networking without password
      {
        groups = [ "network" ];
        commands = [
          { 
            command = "${pkgs.systemd}/bin/systemctl restart NetworkManager";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}