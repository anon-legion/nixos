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
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
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
              environment.systemPackages =  [ inputs.ghostty.packages.${system}.default ];
            }
            inputs.nix-index-database.nixosModules.nix-index
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        thecomeback = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            # inputs.nixvim.homeManagerModules.nixvim
            ./home.nix
          ];
        };
      };
    };
}
