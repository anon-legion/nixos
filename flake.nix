{
  description = "proto flake";

  inputs = {
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      # url = "github:nix-community/home-manager/master";
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:anon-legion/nixvim/thecomeback";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcats = {
      url = "github:anon-legion/nixcats/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos-goober = lib.nixosSystem {
          inherit system;
          modules = [
            inputs.nix-index-database.nixosModules.nix-index
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        thecomeback = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            # inputs.nixvim.homeManagerModules.nixvim
            ./home.nix
          ];
        };
      };
    };
}
