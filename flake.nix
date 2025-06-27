{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For Devenv Python
    nixpkgs-python = {
      url = "github:cachix/nixpkgs-python";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nixpkgs-python, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });

      nixpkgsStableFor = forAllSystems (system: import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      });

      mkHost = { hostname, system }: nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          pkgs = nixpkgsFor.${system};
          pkgs-stable = nixpkgsStableFor.${system};
        };

        modules = [
          ./hosts/${hostname}/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
              inherit inputs;
              pkgs = nixpkgsFor.${system};
              pkgs-stable = nixpkgsStableFor.${system};
            };

            home-manager.users.fabian = import ./users/fabian/${hostname}.nix;
          }
        ];
      };
    in
    {
      formatter = forAllSystems (system: nixpkgsFor.${system}.nixpkgs-fmt);

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
      };
    };
}
