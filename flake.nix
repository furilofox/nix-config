{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });

      nixpkgsUnstableFor = forAllSystems (system: import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      });

      mkHost = { hostname, system }: nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          unstable = nixpkgsUnstableFor.${system};
        };

        modules = [
          ./hosts/${hostname}/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
              inherit inputs;
              unstable = nixpkgsUnstableFor.${system};
            };

            home-manager.users.fabian = import ./users/fabian/${hostname}.nix;
          }
        ];
      };
    in {
      nixosConfigurations = {

        # Main Desktop
        pandora = mkHost {
          hostname = "pandora";
          system = "x86_64-linux";
        };

        # Main Desktop
        promethea = mkHost {
          hostname = "promethea";
          system = "x86_64-linux";
        };

        # Test VM
        gehenna = mkHost {
          hostname = "gehenna";
          system = "x86_64-linux";
        };

        # Example for future host
        # myserver = mkHost {
        #   hostname = "myserver";
        #   system = "x86_64-linux";
        # };
      };
    };
}
