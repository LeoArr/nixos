{
  description = "Leo's NixOS conf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # Leo's ThinkPad T490
      t490 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; };
      	modules = [
          ./hosts/t490/configuration.nix
	  inputs.home-manager.nixosModules.default
	  inputs.catppuccin.nixosModules.catppuccin
        ];
      };
      # Other hosts' config goes here
    };
  };
}