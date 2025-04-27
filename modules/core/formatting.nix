# 'nix fmt .' to format files

{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alejandra
  ];

  programs.nix-index.enable = true;
  
  nixpkgs.config.nix.settings = {
    experimental-features = lib.mkAfter [ "flakes" "nix-command" ];
    formatter = "${pkgs.alejandra}/bin/alejandra";
  };
}