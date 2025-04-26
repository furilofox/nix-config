# VS Code configuration module
{ config, lib, pkgs, pkgs-unstable, ... }:

with lib;

let
  cfg = config.custom.programs.vscode;
in {
  # Define module options
  options.custom.programs.vscode = {
    enable = mkEnableOption "Enable VS Code configuration";

    useUnstable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use the unstable version of VS Code";
    };

    extensions = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of VS Code extensions to install";
      example = literalExpression ''
        [
          "ms-python.python"
          "vscodevim.vim"
        ]
      '';
    };

    userSettings = mkOption {
      type = types.attrs;
      default = {};
      description = "VS Code user settings";
      example = literalExpression ''
        {
          "editor.formatOnSave" = true;
          "editor.minimap.enabled" = false;
        }
      '';
    };
  };

  # Module implementation
  # config = mkIf cfg.enable {
  #   programs.vscode = {
  #     enable = true;
  #     
  #     # Use unstable if configured
  #     package = if cfg.useUnstable
  #       then pkgs-unstable.vscode
  #       else pkgs.vscode;
  #     
  #     # Add extensions from options
  #     extensions = (map 
  #       (ext: if (cfg.useUnstable) 
  #         then pkgs-unstable.vscode-extensions.${ext} or (throw "Extension ${ext} not found in nixpkgs-unstable")
  #         else pkgs.vscode-extensions.${ext} or (throw "Extension ${ext} not found in nixpkgs"))
  #       cfg.extensions);
  #     
  #     # User settings
  #     userSettings = cfg.userSettings;
  #   };
  # };
}