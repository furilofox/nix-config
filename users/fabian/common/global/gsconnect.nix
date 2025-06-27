{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.gsconnect
  ];
}
