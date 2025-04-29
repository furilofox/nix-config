# User-specific configuration for home-manager

{ config, pkgs, unstable, lib, ... }:

{
  imports = [
    ./packages.nix
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

  # Configure shell (e.g., zsh with oh-my-zsh)
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "docker" "sudo" ];
    };
  };

  # Configure your preferred editor
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # Specify State Version (match your NixOS version)
  home.stateVersion = "24.11";
}