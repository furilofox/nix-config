# Custom library functions
{ pkgs, pkgs-unstable, inputs, system, lib }:

{
  # Import helper for unstable packages
  pkgsUnstable = import ./pkgs-unstable.nix pkgs pkgs-unstable;
}