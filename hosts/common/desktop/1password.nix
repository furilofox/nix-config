# 'nix fmt .' to format files

{ config, lib, pkgs, ... }:

{
  programs = {
    _1password = { enable = true; };
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "fabian" ];
    };
  };
}
