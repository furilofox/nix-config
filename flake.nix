{
  description = "My NixOS Configuration";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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

  outputs = { self, nixpkgs, home-manager, nixpkgs-python, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });

      mkHost = { hostname, system }: nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./hosts/${hostname}/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
              inherit inputs;
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

        # Example for future host
        # myserver = mkHost {
        #   hostname = "myserver";
        #   system = "x86_64-linux";
        # };
      };
    };
}
