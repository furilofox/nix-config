# 'nix fmt .' to format files

{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alejandra
  ];

  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;
  programs.nix-index.enableBashIntegration = true; # If you use Bash
  programs.nix-index.enableZshIntegration = true; # If you use Zsh

  nixpkgs.config.nix.settings = {
    experimental-features = lib.mkAfter [ "flakes" "nix-command" ];
    formatter = "${pkgs.alejandra}/bin/alejandra";
  };
}
