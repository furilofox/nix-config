# modules/core/nix.nix
# Configure Nix package manager settings

{ config, lib, pkgs, ... }:

{
  nix = {
    # Enable flakes and new 'nix' command
    package = pkgs.nixVersions.stable;

    # Garbage collection settings
    gc = {
      automatic = true;
      dates = "daily"; # TODO: Set to weekly after im done setting everything up fully
      options = "--delete-older-than 10";
    };

    # Optimize store
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      trusted-users = [ "root" "@wheel" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
