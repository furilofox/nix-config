# OpenSSH service module
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.services.openssh;
in {
  options.custom.services.openssh = {
    enable = mkEnableOption "Enable OpenSSH service with custom config";
    
    port = mkOption {
      type = types.port;
      default = 22;
      description = "Port for SSH daemon";
    };
    
    permitRootLogin = mkOption {
      type = types.enum [ "yes" "no" "prohibit-password" "without-password" "forced-commands-only" ];
      default = "no";
      description = "Whether root login is permitted";
    };
    
    passwordAuthentication = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to allow password authentication";
    };
    
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = "Extra configuration for sshd_config";
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ cfg.port ];
      settings = {
        PasswordAuthentication = cfg.passwordAuthentication;
        PermitRootLogin = cfg.permitRootLogin;
      };
      extraConfig = cfg.extraConfig;
    };
    
    # Automatically open firewall port
    networking.firewall.allowedTCPPorts = [ cfg.port ];
    
    # Add useful message for the user
    system.activationScripts.sshMessage = ''
      echo "SSH server is configured on port ${toString cfg.port}"
    '';
  };
}