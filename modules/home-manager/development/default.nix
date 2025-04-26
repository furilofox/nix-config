# Development tools modules
{ ... }:

{
  imports = [
    ./vscode.nix
    ./virt-manager.nix
    # Add more development modules here as you create them
  ];
}