{ config, lib, unstable, pkgs, ... }:

let
  onePassPath = "~/.1password/agent.sock";
in
{
  # Enable and configure the SSH program
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ${onePassPath}
    '';
  };
}
