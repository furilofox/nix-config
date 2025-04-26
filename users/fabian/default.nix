# Default configuration for user fabian (shared across all hosts)
{ config, lib, pkgs, ... }:

{
  imports = [
    ../default.nix  # Import common user config
  ];
  
  # Common home-manager configuration for fabian on all hosts
  home-manager.users.fabian = { pkgs, pkgs-unstable, lib, ... }: {
    # Let Home Manager manage itself
    programs.home-manager.enable = true;
    
    # Home Manager needs a bit of information about you and the paths it should manage
    home = {
      username = "fabian";
      homeDirectory = "/home/fabian";
      
      # This value determines the Home Manager release that your configuration is
      # compatible with. This helps avoid breakage when a new Home Manager release
      # introduces backwards incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do
      # want to update the value, then make sure to first check the Home Manager
      # release notes.
      stateVersion = "24.11";
    };
    
    # Basic shell configuration
    programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake .#$(hostname)";
      };
      initExtra = ''
        # Add custom bash initialization here
      '';
    };
    
    # Base packages for all hosts
    home.packages = with pkgs; [
      # Common utilities
      wget
      curl
      git
      htop
      mission-center # Task / System Monitor
      
      # Example of using unstable packages
      (lib.custom.pkgsUnstable.pkg "neovim")
    ];
    
    # Default file associations and configuraations
    xdg.enable = true;
    xdg.configFile = {
      # Add files to ~/.config/
    };
    
    # Configure git
    programs.git = {
      enable = true;
      userName = "fabian";
      userEmail = "fabian@example.com";
    };

    custom.programs.vscode = {
      enable = true;
      extensions = [ "ms-python.python" ];
      userSettings = {
        "editor.formatOnSave" = true;
      };
    };
  };
}