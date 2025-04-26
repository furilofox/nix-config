# VS Code configuration module
{ config, lib, pkgs, pkgs-unstable, ... }:

with lib;

let
  cfg = config.custom.programs.virt-manager;
in {
  # Define module options
  options.custom.programs.vscode = {
    enable = mkEnableOption "Enable virt-manager configuration";

    useUnstable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use the unstable version virt-manager";
    };

  };

  # Module implementation
  config = mkIf cfg.enable {
    programs.virt-manager = {
      enable = true;
      
      # Use unstable if configured
      package = if cfg.useUnstable
        then pkgs-unstable.virt-manager
        else pkgs.virt-manager;
    };
    
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest
  };
}