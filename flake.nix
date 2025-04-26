{
  description = "NixOS configuration";

  inputs = {
    # Core nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager for user configurations
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Useful for managing hardware configurations
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux"; # Set your system architecture here

      # Helper function for easier access to unstable packages
      mkPkgs = pkgs: overlays: import pkgs {
        inherit system overlays;
        config.allowUnfree = true; # Allow proprietary software
      };

      # Base packages set (stable)
      pkgs = mkPkgs nixpkgs [ ];

      # Unstable packages set
      pkgs-unstable = mkPkgs nixpkgs-unstable [ ];

      # Library functions
      lib = nixpkgs.lib.extend (final: prev: {
        custom = import ./lib {
          inherit pkgs pkgs-unstable inputs system;
          lib = final;
        };
      });

      # Create a NixOS system configuration for a host
      mkHost = hostname: extraModules: lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs system hostname pkgs pkgs-unstable lib;
        };
        modules = [
          # Basic host configuration
          ./hosts/${hostname}

          # Include home-manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs system hostname pkgs-unstable lib;
            };
          }

          # Include our custom modules
          ./modules/nixos

        ] ++ extraModules;
      };
    in
    {
      nixosConfigurations = {
        # Define your hosts here
        luna = mkHost "luna" [ ];
        # Add more hosts as needed
      };

      # Development shell for working with this flake
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixpkgs-fmt
          nil
        ];
        shellHook = ''
          echo "NixOS configuration development shell"
          echo "Available commands:"
          echo "  nixpkgs-fmt <file>  - Format Nix files"
          echo "  nil <file>          - Nix language server"
        '';
      };
    };
}