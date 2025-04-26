# Font configuration module
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.fonts;
in {
  # Define module options
  options.custom.fonts = {
    enable = mkEnableOption "Enable custom font configuration";

    defaultFonts = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable a set of default fonts";
    };

    extraFonts = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Additional fonts to install";
    };
  };

  # Module implementation
  config = mkIf cfg.enable {
    fonts = {
      packages = (if cfg.defaultFonts then with pkgs; [
        # Default font packages
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
      ] else []) ++ cfg.extraFonts;

      # Font configuration
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "Fira Code" ];
          sansSerif = [ "Noto Sans" ];
          serif = [ "Noto Serif" ];
        };
      };
    };
  };
}