{
  description = "Leo's NixOS conf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: {
    nixosConfigurations = {
      t490 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
      	modules = [
          ./configuration.nix
	  home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.leo = import ./home/default.nix;
	    home-manager.extraSpecialArgs = { inherit hyprland; };
          }
        ];
      };
    };
  };
}