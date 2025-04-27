# modules/core/nix.nix
# Configure Nix package manager settings

{ config, lib, pkgs, ... }:

{
  nix = {
    # Enable flakes and new 'nix' command
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    # Garbage collection settings
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    # Optimize store
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}