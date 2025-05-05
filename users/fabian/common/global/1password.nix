{ config, lib, unstable, pkgs, ... }:

let
  onePassPath = "~/.1password/agent.sock";
in
{
  home.packages = [
    unstable._1password-cli
    unstable._1password-gui
  ];

  # Enable and configure the SSH program
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ${onePassPath}
    '';
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "Furilo";
      };
      "github-school" = {
        hostname = "github.com";
        user = "Fabian";
      };
    };
  };
}
