{
  description = "My NixOS Configuration";

  inputs = {
    # Stable NixOS 24.11
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    # Unstable NixOS for newer packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home-manager for user configurations
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      # System types to support
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      
      # Helper function to generate an attribute set for each supported system
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      
      # Import nixpkgs for each system with custom configuration
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      });
      
      # Import unstable nixpkgs for each system
      nixpkgsUnstableFor = forAllSystems (system: import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      });
    in {
      # Define NixOS configurations for your machines
      nixosConfigurations = {
        # First system - replace "luna" with your actual hostname
        luna = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # Replace with your system architecture if needed
          specialArgs = { 
            inherit inputs;
            # Make unstable packages available as 'unstable' in configs
            unstable = nixpkgsUnstableFor.x86_64-linux;
          };
          modules = [
            # Core system configuration
            ./hosts/luna/configuration.nix
            
            # Import modules
            ./modules/core
            ./modules/desktop
            
            # Home Manager module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.yourusername = import ./users/yourusername;
            }
          ];
        };
        
        # Second system - commented out as a template for future use
        /*
        hostname2 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # Replace with your system architecture if needed
          specialArgs = { 
            inherit inputs;
            # Make unstable packages available as 'unstable' in configs
            unstable = nixpkgsUnstableFor.x86_64-linux;
          };
          modules = [
            # Core system configuration
            ./hosts/hostname2/configuration.nix
            
            # Import modules
            ./modules/core
            ./modules/server # Different modules for different systems
            
            # Home Manager module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.yourusername = import ./users/yourusername;
            }
          ];
        };
        */
      };
    };
}