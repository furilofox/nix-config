# System-level NixOS modules
{ ... }:

{
  imports = [
    ./fonts.nix
    ./locale.nix
    # Add more system modules here as you create them
  ];
}