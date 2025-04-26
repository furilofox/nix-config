# Bash configuration module
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.custom.shell.bash;
in {
  options.custom.shell.bash = {
    enable = mkEnableOption "Enable custom Bash configuration";
    
    aliases = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Shell aliases to define";
      example = literalExpression ''
        {
          ll = "ls -la";
          update = "sudo nixos-rebuild switch --flake .#$(hostname)";
        }
      '';
    };
    
    enableCompletion = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Bash completion";
    };
    
    promptStyle = mkOption {
      type = types.enum [ "minimal" "informative" "colorful" ];
      default = "colorful";
      description = "Style of the Bash prompt";
    };
    
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = "Extra configuration for .bashrc";
    };
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      enableCompletion = cfg.enableCompletion;
      shellAliases = cfg.aliases;
      
      # Basic configuration based on prompt style
      initExtra = 
        (if cfg.promptStyle == "minimal" then ''
          PS1='\$ '
        '' else if cfg.promptStyle == "informative" then ''
          PS1='\u@\h:\w\$ '
        '' else ''
          PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        '') + "\n" + cfg.extraConfig;
    };
    
    # Add helpful CLI tools that make Bash more useful
    home.packages = with pkgs; [
      bat       # Better cat
      exa       # Better ls
      fd        # Better find
      ripgrep   # Better grep
      fzf       # Fuzzy finder
    ];
  };
}