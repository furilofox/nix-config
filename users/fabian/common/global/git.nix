# User-specific configuration for home-manager

{ config, pkgs, unstable, lib, ... }:

{
  # Configure Git
  programs.git = {
    enable = true;
    userName = "Fabian";
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com-personal" = {
        hostname = "github.com";
        user = "git";
        # Specify the public key associated with your personal account in 1Password.
        # You can get the public key from the SSH key item in 1Password.
        identityFile = "../keys/github-personal.pub"; # Path to your *public* key file
        extraOptions = {
          IdentitiesOnly = "yes";
          IdentityAgent = "~/.1password/agent.sock"; # Use the 1Password agent for this host
        };
      };
      "github.com-school" = {
        hostname = "github.com";
        user = "git";
        # Specify the public key associated with your work account in 1Password.
        identityFile = "../keys/github-school.pub"; # Path to your *public* key file
        extraOptions = {
          IdentitiesOnly = "yes";
          IdentityAgent = "~/.1password/agent.sock"; # Use the 1Password agent for this host
        };
      };
      # Add more blocks for additional accounts
    };
  };
}
