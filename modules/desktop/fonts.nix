# modules/desktop/fonts.nix
# Font configuration

{ config, lib, pkgs, ... }:

{
  # Enable fonts in the system
  fonts = {
    # Font packages to install
    packages = with pkgs; [
      # Sans-serif fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      
      # Serif fonts
      dejavu_fonts
      source-serif
      
      # Monospace fonts
      jetbrains-mono
      fira-code
      fira-code-symbols
      source-code-pro
      
      # Icon fonts
      font-awesome
      material-icons
      material-design-icons
      
      # Microsoft compatible fonts
      corefonts  # Required unfree license
      
      # Programming ligature fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "DroidSansMono" ]; })
    ];
    
    # Font configuration
    fontconfig = {
      enable = true;
      
      # Default fonts
      defaultFonts = {
        serif = [ "DejaVu Serif" "Source Serif" ];
        sansSerif = [ "Noto Sans" "Liberation Sans" ];
        monospace = [ "JetBrains Mono" "DejaVu Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
      
      # Font rendering settings
      antialias = true;
      hinting = {
        enable = true;
        style = "slight"; # Options: none, slight, medium, full
      };
      
      # Subpixel rendering
      subpixel = {
        rgba = "rgb"; # Options: none, rgb, bgr, vrgb, vbgr
        lcdfilter = "default"; # Options: none, default, light, legacy
      };
    };
  };
  
  # Enable ConTeXt for document preparation
  # programs.texlive.enable = true;
}