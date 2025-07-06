# modules/core/nix.nix
# Configure Nix package manager settings

{ config, lib, pkgs, ... }:

{
  nix = {
    # Enable flakes and new 'nix' command
    package = pkgs.nixVersions.latest;

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

  # NH for better Nix Commands
  # Auto Garbage Collection
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 14d --keep 5";
    flake = "/home/fabian/Documents/nix-config";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
