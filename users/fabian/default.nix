# User-specific configuration for home-manager

{ config, pkgs, unstable, lib, ... }:

{
  imports = [

  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "fabian";
  home.homeDirectory = "/home/fabian";

  # Configure Git
  programs.git = {
    enable = true;
    userName = "Furilo";
    userEmail = "53122773+furilofox@users.noreply.github.com";
  };

  programs.ssh = {
  enable = true;
  matchBlocks = {
    "github.com-personal" = {
      hostname = "github.com";
      user = "git";
      # Specify the public key associated with your personal account in 1Password.
      # You can get the public key from the SSH key item in 1Password.
      identityFile = "~/.ssh/github-personal.pub"; # Path to your *public* key file
      extraOptions = {
        IdentitiesOnly = "yes";
        IdentityAgent = "~/.1password/agent.sock"; # Use the 1Password agent for this host
      };
    };
    "github.com-school" = {
      hostname = "github.com";
      user = "git";
      # Specify the public key associated with your work account in 1Password.
      identityFile = "~/.ssh/github-school.pub"; # Path to your *public* key file
      extraOptions = {
        IdentitiesOnly = "yes";
        IdentityAgent = "~/.1password/agent.sock"; # Use the 1Password agent for this host
      };
    };
    # Add more blocks for additional accounts
  };
};

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}