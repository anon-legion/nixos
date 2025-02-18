{
  description = "proto flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
          extraSpecialArgs = {
            inherit inputs outputs;
            nhModules = "${self}/modules/home";
          };
          modules = [
            # inputs.nixvim.homeManagerModules.nixvim
            ./home.nix
          ];
        };
      };
    };
}
