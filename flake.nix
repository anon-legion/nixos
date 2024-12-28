{
  description = "proto flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    ghostty.url = "github:ghostty-org/ghostty";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ghostty, home-manager, nix-index-database, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos-goober = lib.nixosSystem {
          inherit system;
          modules = [
            {
              environment.systemPackages =  [ ghostty.packages.${system}.default ];
            }
            ./configuration.nix
            nix-index-database.nixosModules.nix-index
          ];
        };
      };
      homeConfigurations = {
        thecomeback = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}
